import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  final String text;
  const CustomInkWell({
    required this.onTap,
    required this.text,
    super.key,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 50,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
