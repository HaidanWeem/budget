import 'package:budget/budget_router.dart';
import 'package:budget/auth/state/auth_notifier.dart';
import 'package:budget/core/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetApp extends StatefulWidget {
  const BudgetApp({super.key});

  @override
  State<BudgetApp> createState() => _BudgetAppState();
}

class _BudgetAppState extends State<BudgetApp> {
  BudgetRouter? budgetRouter;

  @override
  Widget build(BuildContext context) {
    return InjectionContainer(
      child: Builder(
        builder: (context) {
          budgetRouter = BudgetRouter(context.read<AuthNotifier>());

          return MaterialApp.router(routerConfig: budgetRouter?.router);
        },
      ),
    );
  }
}
