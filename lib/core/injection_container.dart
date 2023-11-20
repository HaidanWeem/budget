import 'package:budget/common/providers/auth_notifier.dart';
import 'package:budget/common/repositories/auth_repository.dart';
import 'package:budget/common/repositories/user_repository.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(_authRepository, _userRepository),
        ),
      ],
      child: widget.child,
    );
  }
}
