import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_screens.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_routing.dart';

class LoginPage extends BaseStatefulPage {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends BaseStatefulState<LoginPage> {
  @override
  void initState() {
    super.initState();

    /// This code block is to demo the show new update version dialog.
    /// TODO: Move this into the [initState()] of first screen of the project (exp: splash_screen.dart).
    if (hasInternetConnection) {
      checkNewUpdate();
    }
  }

  @override
  Widget body() {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Padding(padding: EdgeInsets.only(bottom: 16), child: Text('Login Screen', textAlign: TextAlign.center)),
      TouchableOpacity(
          onPressed: () {
            context.goNamed(RouterName.paginatedListPage);
          },
          child: const Text('Pagination List View'))
    ]));
  }

  @override
  Widget floatingActionButton() {
    /// We does not requires Flutter for future rebuilds
    /// We should use context.read().
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: () => WidgetUtil.showOrHideLayoutBoundaries(),
            child: const Icon(Icons.border_all_rounded)),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: () async => onLoginButtonPressed(withError: false),
          child: const Icon(Icons.login),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: () async => onLoginButtonPressed(withError: true),
          child: const Icon(Icons.error),
        ),
      ],
    );
  }

  @override
  AppBar appbar() {
    return AppBar(
      title: Text(S.current.loginTitle),
      actions: [
        TouchableOpacity(
          padding: const EdgeInsets.all(8),
          onPressed: () => context.read<AppTheme>().toggleThemeMode(),
          child: Builder(
            builder: (context) {
              final themeMode = context.select((AppTheme theme) => theme.themeMode);
              return Icon(themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode);
            },
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _LoginPageState {
  Future<void> onLoginButtonPressed({required bool withError}) async {
    // ! Use tryLoad or tryCatch to load data from ViewModel, it will handle the error that are thrown from the ViewModel
    // ! Use tryCatch if you don't want to show the loading indicator
    final success = await tryLoad(context, () => context.read<LoginViewModel>().sampleLogin(withError: withError));
    if ((success ?? false) && mounted) {
      context.go(AppRouter.home);
    }
  }

  Future<void> checkNewUpdate() async {
    final remoteConfigRes = context.read<AppViewModel>().newVersionRemoteConfigResponse;
    if (!mounted || remoteConfigRes == null) return;

    await WidgetUtil.showRemoteConfigUpdateDialog(
        context: context,
        message: remoteConfigRes.message ?? '',
        updateUrl: remoteConfigRes.updateUrl ?? '',
        isForceUpdate: false);
  }
}
