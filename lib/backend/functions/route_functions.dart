import 'package:flutter/material.dart';

class RouteFunctions {
  final BuildContext context;

  const RouteFunctions({
    required this.context,
  });

  void moveScreen(Widget target, Function callback) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext targetContext) => target,
      ),
    ).then((dynamic result) {
      callback(result);
    });
  }

  void replaceScreen(Widget target) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext targetContext) => target,
      ),
    );
  }

  void backOffScreen(dynamic result) {
    Navigator.of(context).pop(result);
  }
}