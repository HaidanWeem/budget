import 'package:budget/core/budget_messages.dart';

class BudgetUser {
  final String id;
  final String email;

  BudgetUser({
    required this.id,
    required this.email,
  })  : assert(email.isNotEmpty),
        assert(RegExp(BudgetMessages.emailRegexp).hasMatch(email)),
        assert(id.isNotEmpty);

  factory BudgetUser.fromJson(Map<String, dynamic> json, String docId) {
    return BudgetUser(id: docId, email: json['email'].toString());
  }
}
