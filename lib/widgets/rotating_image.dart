import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class RotatingImage extends StatefulWidget {
  final Widget child;
  final Duration? rotationDuration;

  final bool isRotating;

  const RotatingImage({
    Key? key,
    required this.child,
    this.rotationDuration,
    required this.isRotating,
  }) : super(key: key);

  @override
  State<RotatingImage> createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    debugPrint(widget.isRotating.toString());
    _animationController = AnimationController(
        vsync: this,
        duration: widget.rotationDuration ?? const Duration(seconds: 9));
    // ..forward()
    // ..repeat();

    if (widget.isRotating == true) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant RotatingImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isRotating != oldWidget.isRotating) {
      if (widget.isRotating == true) {
        _animationController.repeat();
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: widget.child,
        builder: (_, child) {
          return Transform.rotate(
            angle: _animationController.value * 2 * math.pi,
            child: child,
          );
        });
  }
}
