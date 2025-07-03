import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  String _emailFromCpf(String cpf) {
    final unformattedCpf = cpf.replaceAll(RegExp(r'[^\d]'), '');
    return '$unformattedCpf@tokyomarine.user';
  }

  Future<User?> createUserWithEmailAndPassword({
    required String cpf,
    required String password,
  }) async {
    debugPrint('[AuthService]: Tentando criar usuário...');
    final email = _emailFromCpf(cpf);
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<User?> signInWithEmailAndPassword({
    required String cpf,
    required String password,
  }) async {
    debugPrint('[AuthService]: Tentando logar usuário...');
    debugPrint('[AuthService]: CPF $cpf convertido para o e-mail: ${_emailFromCpf(cpf)}');
    final email = _emailFromCpf(cpf);
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }
  
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
  
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}