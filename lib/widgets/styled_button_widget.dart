
import 'package:flutter/material.dart';

class StyledButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const StyledButtonWidget({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}