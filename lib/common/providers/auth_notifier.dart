import 'package:budget/common/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthRepository _authRepository;

  User? _user;

  User? get user => _user;

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  AuthNotifier(this._authRepository);

  Future<bool> sendSignInLinkToEmail(String email) =>
      _authRepository.sendSignInLinkToEmail(email);

  Future<void> signInWithEmailLink({
    required String email,
    required String link,
  }) async {
    user = await _authRepository.signInWithEmailLink(
      email: email,
      link: link,
    );
  }
}
