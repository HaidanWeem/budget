import 'package:budget/common/repositories/auth_repository.dart';
import 'package:budget/common/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  User? _user;

  User? get user => _user;

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  AuthNotifier(this._authRepository, this._userRepository) {
    _authRepository.authStateChanges.listen((u) {
      user = u;

      if (u == null) return;
      _userRepository.addUser(u);
    });
  }

  Future<bool> sendSignInLinkToEmail(String email) =>
      _authRepository.sendSignInLinkToEmail(email);

  Future<void> signOut() => _authRepository.signOut();
}
