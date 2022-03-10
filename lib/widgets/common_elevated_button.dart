import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Widget buttonChild;
  final Function()? onPress;

  const CommonElevatedButton({
    Key? key,
    this.backgroundColor,
    required this.buttonChild,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: buttonChild,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor ?? const Color.fromARGB(255, 18, 77, 126)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ))),
    );
  }
}
