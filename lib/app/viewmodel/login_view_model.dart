import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

/// ViewModel class as a connector between View and Model,
/// separating View and Model to segregate business logic from UI,
/// by accepting all request from View and perform related request through Model Layer.
/// One ViewModel class may serve multiple View classes. (ensuring Extensibility and Maintainability)
class LoginViewModel extends BaseViewModel {
  UserModel? get userModel => _userModel;
  UserModel? _userModel;

  Future<bool> login(String username, String password) async {
    final response = await UserRepository().login(username, password);

    if (response.data is TokenModel) {
      // Login Success!
      return true;
    }

    notifyListeners();

    /// Check if there are any errors in the response, will throw an exception if there are any errors.
    checkError(response);
    return false;
  }

  Future<bool> sampleLogin({required bool withError}) async {
    MyResponse response;
    if (withError) {
      response = await UserRepository().loginWithError();
    } else {
      response = await UserRepository().loginWithNoError();
    }

    if (response.data is TokenModel) {
      // Login Success!
      notifyListeners();
      return true;
    }

    notifyListeners();
    checkError(response);
    return false;
  }

  Future<void> getProfile() async {
    final response = await UserRepository().getProfile();

    if (response.data is bool && response.data == true) {
      // Update your user model here
      _userModel = UserModel(fullName: 'sample');
    }

    notifyListeners();
    checkError(response);
  }
}
