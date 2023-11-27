import 'package:budget/common/models/operation_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BudgetOperation {
  final double balance;
  final double value;
  final OperationType operationType;
  final String sector;
  final DateTime operationTime;

  BudgetOperation({
    required this.balance,
    required this.value,
    required this.operationType,
    required this.sector,
    required this.operationTime,
  });

  factory BudgetOperation.fromJson(Map<String, dynamic> json) {
    return BudgetOperation(
      balance: double.parse(json['balance'].toString()),
      value: double.parse(json['value'].toString()),
      operationType: OperationType.parse(json['operation_type'].toString()),
      sector: json['operation_type'].toString(),
      operationTime: (json['date_time'] as Timestamp).toDate().toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'value': value,
      'operation_type': operationType.name,
      'sector': sector,
      'date_time': Timestamp.fromDate(operationTime.toUtc()).toString(),
    };
  }
}
