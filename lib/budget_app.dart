import 'package:budget/auth/auth_page.dart';
import 'package:budget/core/injection_container.dart';
import 'package:flutter/material.dart';

class BudgetApp extends StatefulWidget {
  const BudgetApp({super.key});

  @override
  State<BudgetApp> createState() => _BudgetAppState();
}

class _BudgetAppState extends State<BudgetApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: InjectionContainer(
          child: AuthPage(),
        ),
      ),
    );
  }
}
