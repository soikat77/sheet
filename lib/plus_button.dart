import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
