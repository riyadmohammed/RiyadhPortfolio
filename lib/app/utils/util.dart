import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

export 'connection_handler.dart';
export 'recaptcha_handler.dart';
export 'remote_config_handler.dart';

class WidgetUtil {
  /// Show a default error dialog with a single button to dismiss
  static Future<void> showDefaultErrorDialog(BuildContext context, String errorMessage) async {
    final actionBuilders = [
      AdaptiveDialogButtonBuilder(
        text: S.current.textOk,
        isDefaultAction: true,
      ),
    ];
    if (context.mounted) {
      return AdaptiveWidgets.showDialog(
        context,
        title: S.current.errorTitle,
        content: errorMessage,
        actionButtons: actionBuilders,
      );
    }
  }

  static Future<void> showSnackBar(String text) async {
    await Fluttertoast.cancel();
    const duration = 1;

    await Fluttertoast.showToast(
      msg: text,
      // (Kar Seng) Default for Toast.LENGTH_SHORT is 1 second
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      // ignore: avoid_redundant_argument_values
      timeInSecForIosWeb: duration,
      backgroundColor: Colors.black.withValues(alpha: 0.5),
      textColor: Colors.white,
    );
  }

  static void showOrHideLayoutBoundaries() {
    debugPaintSizeEnabled = !debugPaintSizeEnabled;
  }

  static Future<void> checkJailBroken(BuildContext context) async {
    final jailBroken = SharedPreferenceHandler().getRootDetectionJailBroken();
    if (jailBroken) {
      await AdaptiveWidgets.showDialog(
        context,
        title: S.current.errorTitle,
        content: S.current.jailbrokenWarning,
        actionButtons: [
          AdaptiveDialogButtonBuilder(text: S.current.textOk),
        ],
        dismissible: false,
      );
    }
  }

  static AdaptiveDialogButtonBuilder getUpdateButtonBuilder({required String updateUrl}) {
    return AdaptiveDialogButtonBuilder(
      text: S.current.update,
      isDefaultAction: true,
      onPressed: (context) async {
        Navigator.pop(context);
        if (await canLaunchUrlString(updateUrl)) {
          try {
            await launchUrlString(updateUrl);
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      },
    );
  }

  static Future<void> showRemoteConfigUpdateDialog({
    required BuildContext context,
    required String updateUrl,
    required String message,
    bool isForceUpdate = true,
  }) async {
    List<AdaptiveDialogButtonBuilder> actionBuilders = isForceUpdate
        ? [getUpdateButtonBuilder(updateUrl: updateUrl)]
        : [getUpdateButtonBuilder(updateUrl: updateUrl), AdaptiveDialogButtonBuilder(text: S.current.cancel)];

    await AdaptiveWidgets.showDialog(
      context,
      title: isForceUpdate ? S.current.updateRequired : S.current.updateAvailable,
      content: message,
      actionButtons: actionBuilders,
      dismissible: !isForceUpdate,
    );
  }
}

extension WidgetExtension on EdgeInsets {
  EdgeInsets tabletMode(FlutterView flutterView, {bool includeExistingValue = false}) {
    if (SharedPreferenceHandler().getIsTablet()) {
      var tabletPaddingPercentage = 0.05;
      var screenSize = flutterView.physicalSize;
      double width = screenSize.width;
      var leftRightPadding = width * tabletPaddingPercentage;

      var newLeft = includeExistingValue ? left + leftRightPadding : leftRightPadding;
      var newRight = includeExistingValue ? right + leftRightPadding : leftRightPadding;
      return copyWith(left: newLeft, right: newRight);
    }
    return this;
  }
}

extension FontSizeExtension on TextStyle {
  TextStyle tabletFont(FlutterView flutterView) {
    var screenSize = flutterView.physicalSize;
    var ratio = flutterView.devicePixelRatio;
    var logicalPixel = screenSize / ratio;

    double unitHeightValue = logicalPixel.height * 0.01;
    double multiplier = 1.5;

    if (SharedPreferenceHandler().getIsTablet()) {
      return copyWith(fontSize: multiplier * unitHeightValue);
    }
    return this;
  }
}

extension DynamicParsing on dynamic {
  String parseString() => this != null ? toString() : '';

  int parseInt() => this != null ? (int.tryParse(toString()) ?? 0) : 0;

  double parseDouble() => this != null ? (double.tryParse(toString()) ?? 0.0) : 0.0;

  bool parseBool() {
    if (this != null) {
      return this as bool;
    } else {
      return false;
    }
  }

  List<T> parseList<T>() {
    if (this is List) {
      return (this as List).map((item) => item as T).toList();
    }
    return [];
  }
}

extension JsonParsing on dynamic {
  String toJson() => jsonEncode(this);

  Map<String, dynamic> fromJson() => jsonDecode(this) as Map<String, dynamic>;
}
