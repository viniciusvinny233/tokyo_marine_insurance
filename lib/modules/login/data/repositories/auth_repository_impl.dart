import 'package:tokyo_marine_insurance/modules/login/data/services/auth_service.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/entities/user_entity.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  String? _lastUsedCpf;

  AuthRepositoryImpl({required AuthService authService}) : _authService = authService;

  @override
  Future<UserEntity?> login({required String cpf, required String password}) async {
    try {
      final user = await _authService.signInWithEmailAndPassword(
        cpf: cpf,
        password: password,
      );
      
      if (user != null) {
        _lastUsedCpf = cpf;
        return UserEntity(
          id: user.uid,
          cpf: cpf,
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoURL,
        );
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity?> register({required String cpf, required String password}) async {
    try {
      final user = await _authService.createUserWithEmailAndPassword(
        cpf: cpf,
        password: password,
      );
      
      if (user != null) {
        _lastUsedCpf = cpf;
        return UserEntity(
          id: user.uid,
          cpf: cpf,
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoURL,
        );
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _authService.signOut();
    _lastUsedCpf = null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final currentUser = _authService.getCurrentUser();
    if (currentUser != null && _lastUsedCpf != null) {
      return UserEntity(
        id: currentUser.uid,
        cpf: _lastUsedCpf!,
        email: currentUser.email,
        displayName: currentUser.displayName,
        photoUrl: currentUser.photoURL,
      );
    }
    return null;
  }
}