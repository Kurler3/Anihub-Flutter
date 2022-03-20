import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';

class CommonInput extends StatelessWidget {
  final TextEditingController controller;
  final Widget? label;
  final String hintText;
  final String? Function(String?)? validatorFunction;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final int? maxLines;
  final bool isVisible;
  final TextInputType keyboardType;

  const CommonInput({
    Key? key,
    required this.controller,
    this.label,
    required this.hintText,
    this.validatorFunction,
    this.prefixWidget,
    this.maxLines,
    this.keyboardType = TextInputType.text,
    this.suffixWidget,
    this.isVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: darkBlue,
        border: Border.all(color: Colors.blue),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          keyboardType: keyboardType,
          controller: controller,
          maxLines: maxLines ?? 1,
          autofocus: false,
          obscureText: isVisible,
          decoration: InputDecoration(
            fillColor: darkBlue,
            filled: true,
            prefixIcon: prefixWidget,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 5,
              minHeight: 5,
            ),
            isDense: true,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            suffixIcon: suffixWidget,
            label: label,
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
