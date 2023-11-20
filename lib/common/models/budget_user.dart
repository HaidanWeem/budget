import 'package:budget/core/budget_messages.dart';

class BudgetUser {
  final String id;
  final String email;
  final int earnings;

  BudgetUser({
    required this.id,
    required this.email,
    this.earnings = 0,
  }) : assert(email.isNotEmpty),
        assert(RegExp(BudgetMessages.emailRegexp).hasMatch(email)),
        assert(id.isNotEmpty);
}
