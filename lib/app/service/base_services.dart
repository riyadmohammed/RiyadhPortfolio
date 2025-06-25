import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

/// A base class to unified all the required common fields and functions
abstract class BaseServices {
  BaseServices() {
    _init();
  }

  static BaseServices? _instance;
  static String? hostUrl = EnvValues.hostUrl;
  static String? refreshTokenUrl = '/account/refresh'; //subject to change based on backend configuration
  String get apiUrl => hostUrl ?? '';

  /// private access dio instance and accessible using dio() getter
  Dio? _dio;

  /// eg: single dio instance will created and reuse by all services.
  /// remove the needs to create new Dio() instance in every services
  Dio? get dio {
    if (_instance == null || _instance?._dio == null) {
      _instance?._init();
    }
    return _instance?._dio;
  }

  /// Generate the token strings with Bearer Authentication format
  String get authToken {
    return 'Bearer ${SharedPreferenceHandler().getAccessToken()}';
  }

  /// Generate the token strings with Bearer Authentication format
  String get refreshToken {
    return 'Bearer ${SharedPreferenceHandler().getRefreshToken()}';
  }

  /// Function to include all required initialization steps
  /// 1. Create Dio() instance with Options
  /// 2. Added AuthenticationInterceptor to handle JWT Authentication Feature
  Future _init() async {
    _instance = this;
    _dio =
        Dio(BaseOptions(headers: <String, String>{'Content-Type': ContentType.json.value, 'Authorization': authToken}));

    _dio?.interceptors.add(QueuedInterceptorsWrapper(onError: (error, handler) async {
      /// Access Token is considered expired when API return code 401/403
      /// Subject to change depends on backend configuration
      if (error.response?.statusCode == HttpErrorCode.forbidden ||
          error.response?.statusCode == HttpErrorCode.unauthorized) {
        try {
          final responseRefreshToken = await _updateAuthTokenOnce();

          if (responseRefreshToken.error == null) {
            final options = error.response!.requestOptions;
            options.headers['Authorization'] = authToken;

            await Dio().fetch<dynamic>(options).then((r) {
              return handler.resolve(r);
            });
          } else {
            return handler.reject(responseRefreshToken.error);
          }
        } catch (e) {
          if (e is DioException) {
            handler.reject(e);
          }
        }
      }
      return handler.reject(error);
    }));
  }

  static Completer<MyResponse>? _updateAuthTokenCompleter;

  /// To prevent multiple refresh token call at the same time
  Future<MyResponse> _updateAuthTokenOnce() async {
    if (_updateAuthTokenCompleter != null) {
      return _updateAuthTokenCompleter!.future;
    }

    final completer = _updateAuthTokenCompleter = Completer();

    try {
      final token = await _updateAuthToken();
      completer.complete(token);
      _updateAuthTokenCompleter = null;
      return token;
    } catch (ex, stacktrace) {
      completer.completeError(ex, stacktrace);
      rethrow;
    }
  }

  // TODO: Implement your refresh token logic here
  Future<MyResponse> _updateAuthToken() async {
    final path = '$hostUrl/$refreshTokenUrl';
    final response = await callAPI(
      HttpRequestType.post,
      path,
      options: Options(headers: <String, String>{'Authorization': refreshToken}),
      noAuth: true,
    );

    if (response.data is Map<String, dynamic> && response.error == null) {
      final model = TokenModel.fromJson(json.decode(response.data ?? '') as Map<String, dynamic>);

      await SharedPreferenceHandler().putAccessToken(model.accessToken);
      await SharedPreferenceHandler().putRefreshToken(model.refreshToken);

      return MyResponse.complete(model);
    }

    return response;
  }

  /// Standardized api calling with try-catch block
  /// Respond with MyResponse object for consistent data/error handling in services layer
  /// Accessible by all inheriting classes
  Future<MyResponse> callAPI(
    HttpRequestType requestType,
    String path, {
    dynamic postBody,
    Options? options,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    String? savePath,
    bool? noAuth,
  }) async {
    try {
      //dio?.options.contentType = Headers.formUrlEncodedContentType;
      Response? response;

      final client = noAuth ?? false ? Dio() : dio;

      switch (requestType) {
        case HttpRequestType.get:
          response = await client?.get(
            path,
            onReceiveProgress: (count, total) {
              if (total != -1) {
                onReceiveProgress?.call(count, total);
              }
            },
            queryParameters: queryParameters,
          );
        case HttpRequestType.post:
          response = await client?.post(
            path,
            data: postBody,
            options: options,
            queryParameters: queryParameters,
          );
        case HttpRequestType.put:
          response = await client?.put(
            path,
            data: postBody,
            options: options,
            queryParameters: queryParameters,
          );
        case HttpRequestType.patch:
          response = await client?.patch(
            path,
            data: postBody,
            options: options,
            queryParameters: queryParameters,
          );
        case HttpRequestType.delete:
          response = await client?.delete(
            path,
            data: postBody,
            options: options,
            queryParameters: queryParameters,
          );
        case HttpRequestType.download:
          response = await client?.download(
            path,
            savePath,
            options: options,
            queryParameters: queryParameters,
            onReceiveProgress: (count, total) {
              if (total != -1) {
                onReceiveProgress?.call(count, total);
              }
            },
          );
      }

      final code = response?.statusCode;
      if (code == HttpStatus.ok || code == HttpStatus.accepted || code == HttpStatus.created) {
        return MyResponse.complete(response?.data);
      }
    } on DioException catch (e) {
      return _handleDioException(e);
    } catch (e) {
      return MyResponse.error(e.toString());
    }

    return MyResponse.error(DioException(requestOptions: RequestOptions(path: path)));
  }

  MyResponse _handleDioException(DioException e) {
    String? message;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = S.current.apiRequestFailed;
      case DioExceptionType.connectionError:
        message = S.current.noInternetConnectionPlsTryAgain;
      default:
        if (e.response?.data is Map<String, dynamic>) {
          return MyResponse.error(ErrorModel.fromJson(e.response?.data as Map<String, dynamic>).toJson());
        }
        message = e.message;
    }

    return MyResponse.error(
      ErrorModel(
        e.response?.statusCode,
        error: e.error.toString(),
        errorMessage: message,
      ).toJson(),
    );
  }
}
