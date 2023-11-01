import 'package:budget/auth/widgets/auth_text_field.dart';
import 'package:budget/auth/widgets/budget_app_bar.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BudgetAppBar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: AuthTextField(controller: _emailController),
          
        ),
      ],
    );
  }
}
