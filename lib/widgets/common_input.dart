import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CommonInput extends StatelessWidget {
  final TextEditingController controller;
  final Widget label;
  final String hintText;
  final String? Function(String?) validatorFunction;
  final Widget? prefixWidget;
  final int? maxLines;

  const CommonInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.validatorFunction,
    this.prefixWidget,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: inputBackgroundColor,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: prefixWidget,

            // labelStyle: const TextStyle(color: Colors.white),
            // label: label,
            hintMaxLines: maxLines,
            hintText: hintText,
            border: InputBorder.none,
          ),
          validator: validatorFunction,
        ),
      ),
    );
  }
}
