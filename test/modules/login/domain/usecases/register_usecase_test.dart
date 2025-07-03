import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/entities/user_entity.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/repositories/auth_repository.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/register_usecase.dart';

import 'register_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late RegisterUseCase registerUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUseCase = RegisterUseCase(mockAuthRepository);
  });

  const tCpf = '123.456.789-00';
  const tPassword = 'password123';
  final tUserEntity = UserEntity(
    id: 'test-id',
    cpf: tCpf,
    email: 'test@email.com',
    displayName: 'Test User',
    photoUrl: null,
  );

  test('should return UserEntity when register is successful', () async {
    when(mockAuthRepository.register(
      cpf: anyNamed('cpf'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => tUserEntity);

    final result = await registerUseCase(cpf: tCpf, password: tPassword);

    expect(result, equals(tUserEntity));
    verify(mockAuthRepository.register(cpf: tCpf, password: tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return null when register fails', () async {
    when(mockAuthRepository.register(
      cpf: anyNamed('cpf'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => null);

    final result = await registerUseCase(cpf: tCpf, password: tPassword);

    expect(result, isNull);
    verify(mockAuthRepository.register(cpf: tCpf, password: tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
