import 'package:flutter/cupertino.dart';

class TouchableOpacity extends StatelessWidget {
  const TouchableOpacity({
    super.key,
    required this.child,
    this.onPressed,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.pressedOpacity = 0.4,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final Alignment alignment;

  /// The opacity that the button will fade to when it is pressed.
  /// The button will have an opacity of 1.0 when it is not pressed.
  ///
  /// This defaults to 0.4. If null, opacity will not change on pressed if using
  /// your own custom effects is desired.
  final double? pressedOpacity;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      alignment: alignment,
      padding: padding,
      pressedOpacity: pressedOpacity,
      minimumSize: Size(0, 0),
      child: child,
    );
  }
}
