import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_routing.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: providerAssets(), child: const AppWrapper());
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<StatefulWidget> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  void initState() {
    super.initState();
    setupEasyLoading();
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.select((AppViewModel vm) => vm.currentAppLocale);
    final appTheme = context.watch<AppTheme>();
    final showBanner = EnvironmentType.fromAppFlavor(appFlavor) != EnvironmentType.production || kDebugMode;
    final bannerMessage = kDebugMode ? appEnvironmentType.bannerName : capitalize(appEnvironmentType.name);

    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          final easyLoadingInitialiser = EasyLoading.init(
            builder: (context, child) {
              checkDeviceType(context);
              final mediaQueryData = MediaQuery.of(context);
              final scale = mediaQueryData.textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: 1.0);
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: scale), child: child ?? const SizedBox());
            },
          );
          return showBanner
              ? Banner(
                  message: bannerMessage,
                  location: BannerLocation.topEnd,
                  child: easyLoadingInitialiser(context, child))
              : easyLoadingInitialiser(context, child);
        },
        color: Colors.transparent,
        theme: appTheme.lightTheme,
        darkTheme: appTheme.darkTheme,
        themeMode: appTheme.themeMode,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: currentLocale,
        routeInformationParser: CustomRouteParser(
            configuration: router.configuration, onParserException: (context, routeMatchList) => routeMatchList),
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate);
  }

  void checkDeviceType(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    // https://flutter.rocks/2018/01/28/implementing-adaptive-master-detail-layouts/
    var kTabletBreakpoint = 600;
    if (shortestSide < kTabletBreakpoint) {
      SharedPreferenceHandler().putIsTablet(false);
    } else {
      SharedPreferenceHandler().putIsTablet(true);
    }
  }
}

extension on _AppWrapperState {
  void setupEasyLoading() {
    // TODO: update your app loading indicator style here
    EasyLoading.instance.userInteractions = false;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
  }
}
