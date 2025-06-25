part of '../app_theme.dart';

final _primaryDarkAppColors = AppColorsExtension(
  warning: AppPalette.orange.shade400,
  error: AppPalette.red.shade400,
);

// Update your app theme here
final _primaryDark = _defaultDark.copyWith(
  scaffoldBackgroundColor: AppPalette.backgroundColorDark,
  extensions: [
    _primaryDarkAppColors,
  ],
);
