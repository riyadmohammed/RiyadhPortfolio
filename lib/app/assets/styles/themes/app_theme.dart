import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/styles/app_colors_extension.dart';

part 'primary_theme/primary_light_theme.dart';
part 'primary_theme/primary_dark_theme.dart';

enum Themes {
  primary;

  ThemeData get light {
    switch (this) {
      case Themes.primary:
        return _primaryLight;
    }
  }

  ThemeData get dark {
    switch (this) {
      case Themes.primary:
        return _primaryDark;
    }
  }
}

final _defaultLight = ThemeData.light();
final _defaultDark = ThemeData.dark();

class AppTheme with ChangeNotifier {
  // TODO: Set your default theme here
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void toggleThemeMode() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData _lightTheme = Themes.primary.light;
  ThemeData _darkTheme = Themes.primary.dark;

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;

  set theme(Themes theme) {
    _lightTheme = theme.light;
    _darkTheme = theme.dark;
    notifyListeners();
  }
}

extension AppThemeExtension on ThemeData {
  /// Usage example: `Theme.of(context).appColors`;
  AppColorsExtension get appColors => extension<AppColorsExtension>() ?? _primaryLightAppColors;
}

extension ThemeGetter on BuildContext {
  /// Usage example: `context.theme`
  ThemeData get theme => Theme.of(this);
}
