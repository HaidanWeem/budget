import 'package:budget/common/providers/auth_notifier.dart';
import 'package:budget/core/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AuthState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('home page'),
            TextButton(
              onPressed: () => context.read<AuthNotifier>().signOut(),
              child: const Text('sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
