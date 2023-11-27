import 'package:budget/auth/state/auth_notifier.dart';
import 'package:budget/balance/state/balance_notifier.dart';
import 'package:budget/core/repositories/implementations/auth_repository.dart';
import 'package:budget/core/repositories/implementations/balance_repository.dart';
import 'package:budget/core/repositories/implementations/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InjectionContainer extends StatefulWidget {
  final Widget child;

  const InjectionContainer({required this.child, super.key});

  @override
  State<InjectionContainer> createState() => _InjectionContainerState();
}

class _InjectionContainerState extends State<InjectionContainer> {
  final _authRepository = AuthRepository();
  final _userRepository = UserRepository();
  final _balanceRepository = BalanceRepository();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(_authRepository, _userRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => BalanceNotifier(_balanceRepository),
        ),
      ],
      child: widget.child,
    );
  }
}
