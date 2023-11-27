import 'package:budget/auth/state/auth_notifier.dart';
import 'package:budget/core/budget_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

abstract class AuthState<T extends StatefulWidget> extends State<T> {
  AuthNotifier? _authNotfiier;

  @override
  void initState() {
    super.initState();

    _authNotfiier = context.read<AuthNotifier>();
    _authNotfiier?.addListener(_authListener);
  }

  void _authListener() {
    if (!mounted) return;

    _authNotfiier?.user == null
        ? context.go(BudgetRoutes.auth)
        : context.go(BudgetRoutes.home);
  }
}
