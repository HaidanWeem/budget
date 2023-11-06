import 'package:budget/auth/auth_page.dart';
import 'package:budget/common/loading/loading_page.dart';
import 'package:budget/common/providers/auth_notifier.dart';
import 'package:budget/core/budget_routes.dart';
import 'package:budget/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BudgetRouter {
  final AuthNotifier? _authNotifier;

  GoRouter? _router;

  GoRouter? get router => _router;

  BudgetRouter(this._authNotifier) {
    initRoutes();
  }

  void initRoutes() {
    _router = GoRouter(
      routes: [
        _route(path: BudgetRoutes.loading, page: const LoadingPage()),
        _route(path: BudgetRoutes.auth, page: const AuthPage()),
        _route(path: BudgetRoutes.home, page: const HomePage()),
      ],
      redirect: (context, state) {
        return _authNotifier?.user == null
            ? BudgetRoutes.auth
            : BudgetRoutes.home;
      },
    );
  }

  GoRoute _route({required String path, required Widget page}) =>
      GoRoute(path: path, builder: (_, __) => page);
}
