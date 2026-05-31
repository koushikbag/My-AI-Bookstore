import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateToReplacement(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }
  
  static void navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }
  
  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
