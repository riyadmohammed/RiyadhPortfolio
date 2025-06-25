import 'package:flutter/material.dart';

/// Can extends more color properties here
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.warning,
    required this.error,
  });

  final Color warning;
  final Color error;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? warning,
    Color? error,
  }) {
    return AppColorsExtension(
      warning: warning ?? this.warning,
      error: error ?? this.error,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
