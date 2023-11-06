import 'dart:ui';

import 'package:budget/auth/widgets/budget_app_bar.dart';
import 'package:budget/auth/widgets/email_sent.dart';
import 'package:budget/auth/widgets/email_text_field.dart';
import 'package:budget/common/providers/auth_notifier.dart';
import 'package:budget/common/widget/budget_button.dart';
import 'package:budget/core/budget_messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const BudgetAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: EmailTextField(controller: _emailController),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: BudgetButton(
                text: BudgetMessages.continueA,
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onPressed() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final authNotifier = context.read<AuthNotifier>();

    final isSent =
        await authNotifier.sendSignInLinkToEmail(_emailController.text);

    if (mounted && isSent) await showBottomSheet();
  }

  Future<void> showBottomSheet() async {
    final filter = ImageFilter.blur(sigmaX: 10, sigmaY: 10);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: BackdropFilter(
          filter: filter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_downward,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              EmailSent(email: _emailController.text),
            ],
          ),
        ),
      ),
    );
  }
}
