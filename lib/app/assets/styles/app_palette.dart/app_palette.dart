import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';

part 'palettes.dart';

abstract class AppPalette {
  static final primaryColor = _blue.shade500;
  static final primaryColorDark = _blue.shade900;
  static const backgroundColor = Color(0xFFFFFFFF);
  static const backgroundColorDark = Color(0xFF121212);

  static const red = _red;
  static const blue = _blue;
  static const green = _green;
  static const yellow = _yellow;
  static const purple = _purple;
  static const orange = _orange;
  static const gray = _gray;
}
