import 'package:budget/core/budget_images.dart';
import 'package:budget/core/budget_messages.dart';
import 'package:flutter/material.dart';

class EmailSent extends StatelessWidget {
  final String email;

  const EmailSent({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.8;
    final width = MediaQuery.of(context).size.width;
    const iconSize = 120.0;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            BudgetImages.checkmark,
            width: iconSize,
            height: iconSize,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              BudgetMessages.showMessageEmailSent(email),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
