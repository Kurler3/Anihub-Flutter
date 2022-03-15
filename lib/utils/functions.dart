// VALIDATE EMAIL
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

isEmailValid(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);

// GET RANDOM ITEM FROM INDEX
getRandomItem(List array) => array[Random().nextInt(array.length)];

// SHOW SNACKBAR
void showFlushBar({
  required BuildContext context,
  required String? title,
  String? message,
  Widget? mainButton,
  Duration? duration,
  Widget? icon,
  Color? leftBarIndicatorColor,
  EdgeInsets? aroundPadding,
  double? borderRadius,
}) {
  Flushbar(
    padding: aroundPadding ?? const EdgeInsets.all(4.0),
    borderRadius:
        borderRadius != null ? BorderRadius.circular(borderRadius) : null,
    icon: icon,
    leftBarIndicatorColor: leftBarIndicatorColor,
    title: title,
    message: message,
    mainButton: mainButton,
    duration: duration,
  ).show(context);
}

// ROUTE FOR ANIMATION BETWEEN SCREENS
Route createRegisterRouteLeftRight(
  Widget destinationWidget,
) {
  return PageRouteBuilder(
      pageBuilder: ((context, animation, secondaryAnimation) =>
          destinationWidget),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
