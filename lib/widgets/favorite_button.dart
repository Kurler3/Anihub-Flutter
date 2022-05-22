import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final bool isAnimated;
  final bool isFavorited;
  final Function() onClick;
  final Function()? onEnd;

  const FavoriteButton({
    Key? key,
    required this.isAnimated,
    required this.isFavorited,
    required this.onClick,
    this.onEnd,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double?> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _sizeAnimation =
        Tween<double>(begin: 25.0, end: 32.0).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  @override
  void didUpdateWidget(covariant FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // This function is called whenever this Widget is re-built with the same key

    // If this new widget is not animating and the old one is, then start the animation
    if (widget.isFavorited != oldWidget.isFavorited) {
      startAnimating();
    }
  }

  startAnimating() async {
    // IF COMPLETE AND NOT ANIMATING, REVERSE ANIMATION

    await _animationController.forward();
    await _animationController.reverse();

    await Future.delayed(const Duration(
      milliseconds: 200,
    ));

    if (widget.onEnd != null) {
      widget.onEnd!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sizeAnimation,
      child: _likeButton(25.0),
      builder: (context, child) {
        return _likeButton(_sizeAnimation.value!);
      },
    );
  }

  Widget _likeButton(double size) {
    return IconButton(
      onPressed: () {
        // IF IT'S AN ANIMATED WIDGET.
        if (widget.isAnimated) {
          // START ANIMATING
          startAnimating();
          // CALL onClick with new value
          widget.onClick();
        }
      },
      icon: Icon(
        Icons.favorite,
        size: size,
        color: widget.isFavorited ? Colors.red : Colors.grey,
      ),
    );
  }
}
