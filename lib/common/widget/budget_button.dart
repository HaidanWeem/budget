import 'package:budget/core/budget_colors.dart';
import 'package:flutter/material.dart';

class BudgetButton extends StatelessWidget {
  static const _height = 40.0;

  final VoidCallback onPressed;
  final String text;
  final double height;
  final Color overlayColor;
  final Color backgroundColor;

  const BudgetButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = BudgetColors.primary,
    this.overlayColor = BudgetColors.secondary,
    this.height = _height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(overlayColor),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: double.infinity,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
