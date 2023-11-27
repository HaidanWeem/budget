import 'dart:developer';

import 'package:budget/core/repositories/abstract_models.dart/firebase_storage.dart';
import 'package:budget/core/repositories/abstract_models.dart/firebase_user.dart';
import 'package:budget/core/repositories/abstract_models.dart/i_user_repository.dart';

class UserRepository
    with FirebaseUser, FirebaseStorage
    implements IUserRepository {

  @override
  Future<bool> get doesUserExist async {
    final docReference = storage.collection('users').doc(user.uid);
    final data = await docReference.get();

    return data.data()?.isNotEmpty ?? false;
  }

  @override
  Future<void> createUser() async {
    try {
      final userData = {'email': user.email, 'balance': 0};
      await storage.collection('users').doc(user.uid).set(userData);
    } catch (e) {
      log(e.toString());
    }
  }
}
