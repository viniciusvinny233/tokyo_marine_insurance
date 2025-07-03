import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/entities/user_entity.dart';
import '../helpers/mocks.mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockIModularNavigator mockNavigator;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockNavigator = MockIModularNavigator();

    Modular.navigatorDelegate = mockNavigator;
  });

  tearDown(() {
    Modular.destroy();
  });

  test('Login flow - should setup mocks correctly', () {
    when(mockLoginUseCase.call(
      cpf: anyNamed('cpf'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => UserEntity(
          id: '1',
          cpf: '12345678900',
          email: 'test@test.com',
          displayName: 'Test User',
        ));
    
    when(mockNavigator.navigate(any)).thenAnswer((_) async {});

    expect(mockLoginUseCase, isNotNull);
    expect(mockRegisterUseCase, isNotNull);
    expect(mockNavigator, isNotNull);
  });
}