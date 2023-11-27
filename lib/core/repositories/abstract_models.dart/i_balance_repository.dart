import 'package:budget/common/models/budget_operation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IBalanceRepository {
  Stream<DocumentSnapshot<Map<String, dynamic>>> get balanceChanges;
  Future<void> updateBalance(double balance);
  Future<void> createOperation(BudgetOperation operation);
  Future<List<BudgetOperation>> fetchOperations();
  void dispose();
}
