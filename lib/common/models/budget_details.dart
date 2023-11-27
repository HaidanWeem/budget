import 'package:budget/common/models/budget_operation.dart';

class BudgetDetails {
  final String id;
  final double balance;
  final List<BudgetOperation> operations;

  BudgetDetails({
    required this.id,
    required this.balance,
    this.operations = const [],
  });
}
