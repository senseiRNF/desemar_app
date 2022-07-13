import 'package:desemar_app/backend/functions/route_functions.dart';
import 'package:flutter/material.dart';

class DialogFunctions {
  final BuildContext context;
  final String message;

  const DialogFunctions({
    required this.context,
    required this.message,
  });

  void okDialog(Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Attention',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  message,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                RouteFunctions(context: context).backOffScreen(null);
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      callback();
    });
  }

  void optionDialog(Function yes, Function no) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Attention',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  message,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                RouteFunctions(context: context).backOffScreen(false);
              },
              child: const Text(
                'Tidak',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                RouteFunctions(context: context).backOffScreen(true);
              },
              child: const Text(
                'Ya',
              ),
            ),
          ],
        );
      },
    ).then((result) {
      if(result != null) {
        if(result) {
          yes();
        } else {
          no();
        }
      }
    });
  }
}