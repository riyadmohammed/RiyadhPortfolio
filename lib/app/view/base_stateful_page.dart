import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_screens.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({super.key});
}

/// A basic state that include common widgets and Ui logic handling
abstract class BaseStatefulState<Page extends BaseStatefulPage> extends State<Page>
    with WidgetsBindingObserver, ErrorHandlingMixin {
  /// Basic component helper
  AppBar? appbar() => null;

  Widget body();

  Widget? floatingActionButton() => null;

  /// Styling helper
  Size size() => MediaQuery.of(context).size;

  FlutterView flutterView() => View.of(context);

  double width() => size().width;

  double height() => size().height;

  double usableWidthWithoutPadding() => width() - EdgeInsets.zero.tabletMode(flutterView()).horizontal;

  Color backgroundColor() => context.theme.scaffoldBackgroundColor;

  bool extendBodyBehindAppBar() => false;

  bool topSafeAreaEnabled() => true;

  Widget? bottomNavigationBar() => null;

  bool hasInternetConnection = true;

  bool hasForceUpdate = false;

  bool isUnderMaintenance = false;

  BuildContext? underMaintenanceScreenContext;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    hasInternetConnection = context.read<AppViewModel>().hasInternet;
    hasForceUpdate =
        context.read<AppViewModel>().forceUpdateRemoteConfigResponse?.type == RemoteConfigResponseType.needForceUpdate;
  }

  /// Each Page are meant to be build with a [Scaffold] structure
  /// include with [AppBar], [Body], [FloatingActionButton]
  @override
  Widget build(BuildContext context) {
    hasInternetConnection = context.select((AppViewModel viewModel) => viewModel.hasInternet);
    hasForceUpdate = context.select((AppViewModel viewModel) => viewModel.forceUpdateRemoteConfigResponse) != null;
    isUnderMaintenance = context.select((AppViewModel viewModel) => viewModel.isUnderMaintenance);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await WidgetUtil.checkJailBroken(context);
      if (hasForceUpdate) await checkForceUpdate();

      if (isUnderMaintenance) {
        await checkIsUnderMaintenance();
      } else {
        if (underMaintenanceScreenContext != null && (underMaintenanceScreenContext?.mounted ?? false)) {
          Navigator.of(underMaintenanceScreenContext!).pop();
          underMaintenanceScreenContext = null;
        }
      }
    });

    return Scaffold(
      backgroundColor: backgroundColor(),
      extendBodyBehindAppBar: extendBodyBehindAppBar(),
      appBar: appbar(),
      body: SafeArea(
        left: false,
        right: false,
        top: topSafeAreaEnabled(),
        bottom: false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: body(),
        ),
      ),
      floatingActionButton: floatingActionButton(),
      bottomNavigationBar: bottomNavigationBar(),
      resizeToAvoidBottomInset: true,
    );
  }
}

extension on BaseStatefulState {
  Future<void> checkForceUpdate() async {
    final remoteConfigRes = context.read<AppViewModel>().forceUpdateRemoteConfigResponse;
    if (!mounted) return;

    if (hasForceUpdate) {
      await WidgetUtil.showRemoteConfigUpdateDialog(
        context: context,
        message: remoteConfigRes?.message ?? '',
        updateUrl: remoteConfigRes?.updateUrl ?? '',
      );
    }
  }

  Future<void> checkIsUnderMaintenance() async {
    if (!mounted) return;

    if (isUnderMaintenance) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (context) {
          underMaintenanceScreenContext = context;
          return const Dialog.fullscreen(
            child: MaintenancePage(),
          );
        },
      );
    }
  }
}
