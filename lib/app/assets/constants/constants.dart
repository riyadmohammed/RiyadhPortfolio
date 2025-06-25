import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';

export 'enums/enums.dart';

enum HttpRequestType { get, post, put, patch, delete, download }

final appEnvironmentType = EnvironmentType.fromAppFlavor(appFlavor);

class EnvValues {
  EnvValues._();

  static const hostUrl = String.fromEnvironment('hostUrl');

  static const _recaptchaSiteKeyIOS = String.fromEnvironment('recaptchaSiteKeyIOS');
  static const _recaptchaSiteKeyAndroid = String.fromEnvironment('recaptchaSiteKeyAndroid');
  static String get recaptchaSiteKey => Platform.isIOS ? _recaptchaSiteKeyIOS : _recaptchaSiteKeyAndroid;
}

class HttpErrorCode {
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int none = 0;
}

enum Language {
  english('en'),
  bm('ms');

  final String languageCode;
  const Language(this.languageCode);

  String get label {
    switch (this) {
      case english:
        return S.current.english;
      case bm:
        return S.current.bm;
    }
  }
}

class FileSize {
  static const imageQuality = 100;
  static const kilobyte = 1024;
  static const fileSizeLimit = 5;
}

class GeneralConstant {
  static const int defaultPageKey = 0;
  static const int defaultPageTake = 20;
}
