import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: _Styles.containerPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  getIcon(context),
                  const SizedBox(height: _Styles.titleLabelTopSpacing),
                  getTitleLabel(context),
                  const SizedBox(height: _Styles.messageLabelTopSpacing),
                  getMessageLabel(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MaintenancePage {
  // * Icon
  Widget getIcon(BuildContext context) {
    return const Icon(
      Icons.engineering_rounded,
      color: _Styles.iconColor,
      size: _Styles.iconSize,
    );
  }

  // * Title Label
  Widget getTitleLabel(BuildContext context) {
    return Text(
      S.current.underMaintenanceTitle,
      style: _Styles.titleLabelStyle,
    );
  }

  // * Message Label
  Widget getMessageLabel(BuildContext context) {
    return Text(
      S.current.underMaintenanceMessage,
      textAlign: TextAlign.center,
      style: _Styles.messageLabelStyle,
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  static const containerPadding = EdgeInsets.symmetric(horizontal: 24.0);

  // * Icon
  static const iconSize = 96.0;
  static const iconColor = Color(0xFFB7B7B7);

  // * Title Label
  static const titleLabelTopSpacing = 4.0;
  static const titleLabelStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF403A3A),
  );

  // * Message Label
  static const messageLabelTopSpacing = 8.0;
  static const messageLabelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF8E8E8E),
  );
}
