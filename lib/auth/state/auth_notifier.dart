import 'package:budget/common/models/budget_user.dart';
import 'package:budget/core/repositories/abstract_models.dart/i_auth_repository.dart';
import 'package:budget/core/repositories/abstract_models.dart/i_user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  BudgetUser? _budgetUser;

  BudgetUser? get user => _budgetUser;

  set user(BudgetUser? user) {
    _budgetUser = user;
    notifyListeners();
  }

  AuthNotifier(this._authRepository, this._userRepository) {
    _authRepository.authStateChanges.listen(_authStateChangesLinstener);
  }

  Future<void> _authStateChangesLinstener(User? firebaseUser) async {
    if (firebaseUser == null) return user = null;

      user = BudgetUser(id: firebaseUser.uid, email: firebaseUser.email ?? '');

      if (await _userRepository.doesUserExist) return;

      await _userRepository.createUser();
  }

  Future<bool> sendSignInLinkToEmail(String email) =>
      _authRepository.sendSignInLinkToEmail(email);

  Future<void> signOut() => _authRepository.signOut();
}
