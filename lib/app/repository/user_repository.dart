import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

/// Repository class is defining the business logic for accessing data source,
/// eg:
/// 1. getting data from multiple source and compiled as one data type before passing back to ViewModel.
/// 2. decide when to return CacheData or Actual Realtime ServerData
/// 3. And many more
class UserRepository {
  final UserServices _userServices = UserServices();

  Future<MyResponse> login(String username, String password) async {
    final response = await _userServices.login(username, password);
    if (response.data is Map<String, dynamic> && response.error == null) {
      // It's just a sample on how to process the sercive response, replace it with your model
      return MyResponse.complete(TokenModel(accessToken: 'accessToken', refreshToken: 'refreshToken'));
    }

    return response;
  }

  Future<MyResponse> loginWithNoError() async {
    await Future.delayed(const Duration(seconds: 2));
    return MyResponse.complete(TokenModel(accessToken: 'accessToken', refreshToken: 'refreshToken'));
  }

  Future<MyResponse> loginWithError() async {
    await Future.delayed(const Duration(seconds: 2));
    return MyResponse.error(ErrorModel(HttpStatus.badRequest, errorMessage: 'Invalid username or password').toJson());
  }

  Future<MyResponse> getProfile() async {
    // TODO: For demo purpose I will force return true, replace it with your model
    await Future.delayed(const Duration(seconds: 2));
    return MyResponse.complete(true);

    // final response = await _userServices.getProfile();
    // if (response.data is Map<String, dynamic> && response.error == null) {
    //   return MyResponse.complete(true);
    // }

    // return response;
  }
}
