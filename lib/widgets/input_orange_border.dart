import 'package:flutter/material.dart';
import '../utils/colors.dart';

class InputOrangeBorder extends StatelessWidget {
  final TextEditingController controller;
  final Widget label;
  final String hintText;
  final String? Function(String?) validatorFunction;

  const InputOrangeBorder({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.validatorFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        label: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: buttonOrange)),
      ),
      validator: validatorFunction,
    );
  }
}
