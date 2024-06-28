import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 500),
      backgroundColor: (e == 'Success') ? Colors.white : Colors.black,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      content: Text(
        e,
        style: TextStyle(color: (e == 'Success') ? Colors.black : Colors.white),
      ),
    ),
  );
}
