import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

/// Define the type of environment supported in this project
enum EnvironmentType {
  staging,
  production;

  factory EnvironmentType.fromAppFlavor(String? flavor) {
    switch (flavor) {
      case 'staging':
        return EnvironmentType.staging;
      case 'production':
        return EnvironmentType.production;
      default:
        return EnvironmentType.staging;
    }
  }

  // TODO: Setup your app name here
  String get appName {
    switch (this) {
      case EnvironmentType.staging:
        return '[S] Dumb Dumb';
      case EnvironmentType.production:
        return 'Dumb Dumb';
    }
  }

  String get bannerName {
    switch (this) {
      case EnvironmentType.staging:
        return 'Debug[S]';
      case EnvironmentType.production:
        return 'Debug[P]';
    }
  }
}

/// Declaring all the ViewModel that to be use in Provider + ChangeNotifier
/// All registered providers here will be set into [MultiProvider] in [app.dart]
/// All registered providers are configured at the deepest layer of inheritance widget
/// ensuring any screen in this app will be able to access to the providers
List<SingleChildWidget> providerAssets() => [
      ChangeNotifierProvider(create: (_) => AppTheme()),
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ChangeNotifierProvider(create: (_) => AppViewModel()),

      /// TODO: This is a dummy setup. Remove this route in the actual project.
      ChangeNotifierProvider(create: (_) => VenueListingViewModel()),
    ];

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
