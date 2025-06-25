import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {
  static final SharedPreferenceHandler _instance = SharedPreferenceHandler._internal();

  static SharedPreferences? _sharedPreferences;

  static const spUser = 'userInfo';
  static const spAccessToken = 'accessToken';
  static const spRefreshToken = 'refreshToken';
  static const spLanguageCode = 'language';
  static const spJailBroken = 'rootDetectionJailBroken';
  static const spDeveloperMode = 'rootDetectionDeveloperMode';
  static const spTabletMode = 'tabletMode';

  /// Factory constructor that returns the single instance.
  factory SharedPreferenceHandler() {
    return _instance;
  }

  SharedPreferenceHandler._internal();

  Future<void> initialize() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> logout() async {
    if (_sharedPreferences == null) return;

    await Future.wait([
      _sharedPreferences!.remove(spUser),
      _sharedPreferences!.remove(spAccessToken),
      _sharedPreferences!.remove(spRefreshToken),
    ]);
  }

  Future<bool?> putUser(String user) async {
    return _sharedPreferences?.setString(spUser, user);
  }

  UserModel? getUser() {
    try {
      final userInfo = _sharedPreferences?.getString(spUser) ?? '';

      if (userInfo.isNotEmpty) {
        final userMap = jsonDecode(userInfo) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      debugPrint('error: $e');
    }
    return null;
  }

  Future<bool?> putAccessToken(String? token) async {
    return _sharedPreferences?.setString(spAccessToken, token ?? '');
  }

  Future<bool?> putRefreshToken(String? token) async {
    return _sharedPreferences?.setString(spRefreshToken, token ?? '');
  }

  Future<bool?> putLanguageCode(String? language) async {
    return _sharedPreferences?.setString(spLanguageCode, language ?? '');
  }

  Future<bool?> putRootDetectionJailBroken(bool jailBroken) async {
    return _sharedPreferences?.setBool(spJailBroken, jailBroken);
  }

  Future<bool?> putRootDetectionDeveloperMode(bool developerMode) async {
    return _sharedPreferences?.setBool(spDeveloperMode, developerMode);
  }

  Future<bool?> putIsTablet(bool isTablet) async {
    return _sharedPreferences?.setBool(spTabletMode, isTablet);
  }

  String getAccessToken() {
    return _sharedPreferences?.getString(spAccessToken) ?? '';
  }

  String getRefreshToken() {
    return _sharedPreferences?.getString(spRefreshToken) ?? '';
  }

  String getLanguageCode() {
    return _sharedPreferences?.getString(spLanguageCode) ?? '';
  }

  bool getRootDetectionJailBroken() {
    return _sharedPreferences?.getBool(spJailBroken) ?? false;
  }

  bool getRootDetectionDeveloperMode() {
    return _sharedPreferences?.getBool(spDeveloperMode) ?? false;
  }

  bool getIsTablet() {
    return _sharedPreferences?.getBool(spTabletMode) ?? false;
  }
}
