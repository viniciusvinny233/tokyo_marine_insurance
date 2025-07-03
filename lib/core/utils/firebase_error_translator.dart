import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorTranslator {
  static String translateError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-credential':
      case 'wrong-password':
        return 'Credencial de autenticação incorreta, mal formatada ou expirada.';
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'user-disabled':
        return 'Este usuário foi desativado.';
      case 'too-many-requests':
        return 'Muitas tentativas de login. Por favor, tente novamente mais tarde.';
      case 'operation-not-allowed':
        return 'Operação não permitida.';
      case 'email-already-in-use':
        return 'Este e-mail já está sendo usado por outra conta.';
      case 'weak-password':
        return 'A senha fornecida é muito fraca.';
      case 'invalid-email':
        return 'O endereço de e-mail não é válido.';
      default:
        if (exception.message?.contains('auth credential is incorrect') == true) {
          return 'Credencial de autenticação incorreta, mal formatada ou expirada.';
        }
        return exception.message ?? 'Ocorreu um erro na autenticação.';
    }
  }
}