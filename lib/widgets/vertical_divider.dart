import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const CustomVerticalDivider({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        color: color,
        height: height,
        width: width,
      ),
    );
  }
}
