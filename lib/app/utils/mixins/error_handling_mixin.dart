import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// A mixin for handling errors in asynchronous operations gracefully,
/// providing utilities to try operations and catch errors with optional
/// error dialog presentations.
mixin ErrorHandlingMixin {
  /// Tries to execute a given asynchronous [fn] function, showing an error
  /// dialog if an error occurs and [shouldShowAlert] is true.
  /// Returns the result of [fn] if successful, or [null] if an error occurs.
  ///
  /// [BuildContext] context is required for showing dialogs.
  /// [Future<T?> Function()] fn is the asynchronous operation to try.
  /// [bool] shouldShowAlert determines whether to show an error dialog.
  Future<T?> tryCatch<T>(
    BuildContext context,
    Future<T?> Function() fn, {
    bool shouldShowAlert = true,
  }) async {
    try {
      return await fn();
    } on UrgentErrorException catch (e, stackTrace) {
      if (context.mounted) {
        unawaited(_handleUrgentError(context, e, stackTrace));
      }
      return null;
    } on NormalErrorException catch (e, stackTrace) {
      if (context.mounted) {
        _handleOtherError(context, shouldShowAlert, e.message, stackTrace);
      }
      return null;
    } catch (e, stackTrace) {
      if (context.mounted) {
        _handleOtherError(context, shouldShowAlert, e, stackTrace);
      }
      return null;
    }
  }

  /// Similar to [tryCatch], but shows a loading indicator while [fn] is executing.
  /// Automatically dismisses the loading indicator once [fn] completes or an error occurs.
  ///
  /// Use this for operations where visual feedback during loading is desired.
  Future<T?> tryLoad<T>(
    BuildContext context,
    Future<T?> Function() fn, {
    bool shouldShowAlert = true,
  }) async {
    await EasyLoading.show();

    try {
      return await fn();
    } on UrgentErrorException catch (e, stackTrace) {
      if (context.mounted) {
        unawaited(_handleUrgentError(context, e, stackTrace));
      }
      return null;
    } on NormalErrorException catch (e, stackTrace) {
      if (context.mounted) {
        _handleOtherError(context, shouldShowAlert, e.message, stackTrace);
      }
      return null;
    } catch (e, stackTrace) {
      if (context.mounted) {
        _handleOtherError(context, shouldShowAlert, e, stackTrace);
      }
      return null;
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<void> _handleUrgentError(BuildContext context, UrgentErrorException e, StackTrace stackTrace) async {
    if (context.mounted) {
      await WidgetUtil.showDefaultErrorDialog(context, e.message);
      if (context.mounted) {
        // TODO: Logout Here
        // unawaited(tryLoad(context, context.read<UserAuthViewModel>().logout));
      }
    }
    debugPrint('Error: $e\nStack Trace: $stackTrace');
  }

  void _handleOtherError(BuildContext context, bool shouldShowAlert, dynamic e, StackTrace stackTrace) {
    if (shouldShowAlert && context.mounted) {
      WidgetUtil.showDefaultErrorDialog(context, e.toString());
    }

    debugPrint('Error: $e\nStack Trace: $stackTrace');
  }
}
