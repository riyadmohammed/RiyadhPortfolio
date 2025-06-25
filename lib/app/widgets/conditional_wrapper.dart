import 'package:flutter/widgets.dart';

class ConditionalWrapper extends StatelessWidget {
  final Widget child;
  final bool shouldWrap;
  final Widget Function(Widget) wrapper;

  const ConditionalWrapper({
    super.key,
    required this.child,
    required this.shouldWrap,
    required this.wrapper,
  });

  @override
  Widget build(BuildContext context) {
    if (shouldWrap) {
      return wrapper(child);
    } else {
      return child;
    }
  }
}
