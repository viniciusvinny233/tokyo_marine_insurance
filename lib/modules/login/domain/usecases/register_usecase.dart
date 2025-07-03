import 'package:tokyo_marine_insurance/modules/login/domain/entities/user_entity.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity?> call({required String cpf, required String password}) async {
    return await repository.register(cpf: cpf, password: password);
  }
}