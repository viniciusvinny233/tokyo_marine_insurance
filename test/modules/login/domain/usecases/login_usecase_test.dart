import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/entities/user_entity.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/repositories/auth_repository.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/login_usecase.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  final tCpf = '123.456.789-00';
  final tPassword = 'password123';
  final tUserEntity = UserEntity(
    id: 'test-id',
    cpf: tCpf,
    email: 'test@email.com',
    displayName: 'Test User',
    photoUrl: null,
  );

  test('should return UserEntity when login is successful', () async {
    when(mockAuthRepository.login(
      cpf: anyNamed('cpf'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => tUserEntity);

    final result = await loginUseCase(cpf: tCpf, password: tPassword);

    expect(result, equals(tUserEntity));
    verify(mockAuthRepository.login(cpf: tCpf, password: tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return null when login fails', () async {
    when(mockAuthRepository.login(
      cpf: anyNamed('cpf'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => null);

    final result = await loginUseCase(cpf: tCpf, password: tPassword);

    expect(result, isNull);
    verify(mockAuthRepository.login(cpf: tCpf, password: tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
