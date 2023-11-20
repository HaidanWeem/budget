import 'dart:developer';

import 'package:budget/common/repositories/storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository extends StorageRepository {
  Future<bool> doesUserExist(String id) async {
    final docReference = storage.collection('users').doc(id);
    final data = await docReference.get();

    return data.data()?.isNotEmpty ?? false;
  }

  Future<void> addUser(User user) async {
    final isExist = await doesUserExist(user.uid);
    if (isExist) return;
    try {
      final userData = {'email': user.email, 'earnings': 0};
      await storage.collection('users').doc(user.uid).set(userData);
    } catch (e) {
      log(e.toString());
    }
  }
}
