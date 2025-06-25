import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

/// A base class to unified all the required common fields and functions
/// Inherited with ChangeNotifier for Provider State Management
/// All inheriting classes will be able to access these values and features
abstract class BaseViewModel with ChangeNotifier {
  /// A function that handles error responses from the API.
  /// It will throw an exception if there are any errors.
  /// Ensure to handle these exceptions with the [tryLoad] or [tryCatch] methods in the UI.
  void checkError(MyResponse response) {
    if (response.status == ResponseStatus.error && response.error != null && response.error is Map<String, dynamic>) {
      ErrorModel error = ErrorModel.fromJson(response.error);
      if (error.isForbidden) {
        throw UrgentErrorException(S.current.sessionExpiredMessage);
      }
      throw NormalErrorException(error.errorMessage ?? S.current.apiRequestFailed);
    }
  }
}

class UrgentErrorException implements Exception {
  final String message;

  UrgentErrorException(this.message);
}

class NormalErrorException implements Exception {
  final String message;

  NormalErrorException(this.message);
}
