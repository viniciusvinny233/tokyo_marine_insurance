import 'package:tokyo_marine_insurance/modules/login/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> login({required String cpf, required String password});
  Future<UserEntity?> register({required String cpf, required String password});
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
}