import 'dart:async';
import 'dart:developer';

import 'package:budget/common/models/budget_operation.dart';
import 'package:budget/core/repositories/abstract_models.dart/firebase_storage.dart';
import 'package:budget/core/repositories/abstract_models.dart/firebase_user.dart';
import 'package:budget/core/repositories/abstract_models.dart/i_balance_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BalanceRepository
    with FirebaseStorage, FirebaseUser
    implements IBalanceRepository {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userSubscriotion;

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> get balanceChanges =>
      storage.collection('details').doc(user.uid).snapshots();

  BalanceRepository() {
    _userSubscriotion = storage
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((event) async {
      if (event.exists && !await doesBalanceExist()) {
        await _createBalance();
      }
    });
  }

  Future<bool> doesBalanceExist() async {
    final data = await storage.collection('details').doc(user.uid).get();

    return data.exists;
  }

  @override
  Future<List<BudgetOperation>> fetchOperations() async {
    final operations = await storage
        .collection('details')
        .doc(user.uid)
        .collection('operations')
        .get();

    return operations.docs
        .map((e) => BudgetOperation.fromJson(e.data()))
        .toList();
  }

  @override
  Future<void> createOperation(BudgetOperation operation) async {
    try {
      await storage
          .collection('details')
          .doc(user.uid)
          .collection('operations')
          .doc()
          .set(operation.toJson());

      await updateBalance(operation.balance);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _createBalance() async {
    try {
      await storage.collection('details').doc(user.uid).set({'balance': 0});
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> updateBalance(double balance) async {
    try {
      await storage
          .collection('details')
          .doc(user.uid)
          .update({'balance': balance});
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    _userSubscriotion?.cancel();
  }
}
