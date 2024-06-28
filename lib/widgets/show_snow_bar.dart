import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: (e == 'Success') ? Colors.black : Colors.white,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      content: Text(
        e,
        style: TextStyle(color: (e == 'Success') ? Colors.white : Colors.black),
      ),
    ),
  );
}
