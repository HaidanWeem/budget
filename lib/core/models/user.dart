import 'package:budget/core/models/cost_type/cost_type.dart';

class User {
  final String userName;
  final List<CostType> expences;
  final int income;

  const User({
    required this.userName,
    this.expences = const [],
    this.income = 0,
  });
}
