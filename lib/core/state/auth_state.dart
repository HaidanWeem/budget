import 'package:budget/common/providers/auth_notifier.dart';
import 'package:budget/core/budget_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

abstract class AuthState<T extends StatefulWidget> extends State {
  AuthNotifier? _authNotfiier;

  @override
  void initState() {
    super.initState();

    _authNotfiier = context.read<AuthNotifier>()..addListener(_authListener);
  }

  void _authListener() {
    final isAuthenticated = _authNotfiier?.user != null;
    isAuthenticated
        ? context.go(BudgetRoutes.home)
        : context.go(BudgetRoutes.auth);
  }
}
