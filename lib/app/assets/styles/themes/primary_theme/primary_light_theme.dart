part of '../app_theme.dart';

final _primaryLightAppColors = AppColorsExtension(
  warning: AppPalette.orange.shade500,
  error: AppPalette.red.shade500,
);

// Update your app theme here
final _primaryLight = _defaultLight.copyWith(
  primaryColor: AppPalette.purple.shade500,
  bottomNavigationBarTheme: _defaultLight.bottomNavigationBarTheme.copyWith(),
  shadowColor: AppPalette.purple.shade500,
  navigationBarTheme: _getPrimaryNavigationBarTheme(),
  scaffoldBackgroundColor: AppPalette.backgroundColor,
  extensions: [
    _primaryLightAppColors,
  ],
);

NavigationBarThemeData _getPrimaryNavigationBarTheme() {
  return _defaultLight.navigationBarTheme.copyWith(
    backgroundColor: AppPalette.backgroundColor,
    elevation: 10,
    shadowColor: AppPalette.gray.shade600,
    indicatorColor: AppPalette.purple.shade100,
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(color: AppPalette.purple.shade500);
      }
      return IconThemeData(color: AppPalette.gray.shade700);
    }),
  );
}
