import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String id;
  final String cpf;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  UserEntity({
    required this.id,
    required this.cpf,
    this.email,
    this.displayName,
    this.photoUrl,
  });

  factory UserEntity.fromFirebaseUser(User user, {required String cpf}) {
    return UserEntity(
      id: user.uid,
      cpf: cpf,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}