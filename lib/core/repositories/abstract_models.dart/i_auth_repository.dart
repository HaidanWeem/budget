import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Stream<User?> get authStateChanges;
  Future<bool> sendSignInLinkToEmail(String email);
  Future<void> signOut();
}
