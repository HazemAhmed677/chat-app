import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  final String text;
  const CustomGestureDetector({
    required this.onTap,
    required this.text,
    super.key,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 50,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ));
  }
}
