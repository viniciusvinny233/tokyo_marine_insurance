import 'package:tokyo_marine_insurance/modules/login/domain/entities/user_entity.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity?> call({required String cpf, required String password}) async {
    return await repository.login(cpf: cpf, password: password);
  }
}