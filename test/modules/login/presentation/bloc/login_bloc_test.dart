import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/entities/user_entity.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/login_usecase.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/register_usecase.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/bloc/login_bloc.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginUseCase, RegisterUseCase])
void main() {
  late LoginBloc loginBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    loginBloc = LoginBloc(
      loginUseCase: mockLoginUseCase,
      registerUseCase: mockRegisterUseCase,
    );
  });

  tearDown(() {
    loginBloc.close();
  });

  test('initial state should be LoginState with authMode login and formStatus initial', () {
    expect(loginBloc.state.authMode, equals(AuthMode.login));
    expect(loginBloc.state.formStatus, equals(FormStatus.initial));
    expect(loginBloc.state.errorMessage, isNull);
  });

  blocTest<LoginBloc, LoginState>(
    'should emit [LoginState with authMode register] when LoginTabChanged is added with AuthMode.register',
    build: () => loginBloc,
    act: (bloc) => bloc.add(const LoginTabChanged(AuthMode.register)),
    expect: () => [
      const LoginState(authMode: AuthMode.register, formStatus: FormStatus.initial),
    ],
  );

  group('LoginSubmitted', () {
    final tCpf = '123.456.789-00';
    final tPassword = 'password123';
    final tUserEntity = UserEntity(
      id: 'test-id',
      cpf: tCpf,
      email: 'test@email.com',
      displayName: 'Test User',
      photoUrl: null,
    );

    blocTest<LoginBloc, LoginState>(
      'should emit [loading, success] when login is successful',
      build: () {
        when(mockLoginUseCase(
          cpf: anyNamed('cpf'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => tUserEntity);
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(cpf: tCpf, password: tPassword)),
      expect: () => [
        const LoginState(authMode: AuthMode.login, formStatus: FormStatus.loading),
        const LoginState(authMode: AuthMode.login, formStatus: FormStatus.success),
      ],
      verify: (_) {
        verify(mockLoginUseCase(cpf: tCpf, password: tPassword));
      },
    );

    blocTest<LoginBloc, LoginState>(
      'should emit [loading, error] when login fails with null user',
      build: () {
        when(mockLoginUseCase(
          cpf: anyNamed('cpf'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => null);
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(cpf: tCpf, password: tPassword)),
      expect: () => [
        const LoginState(authMode: AuthMode.login, formStatus: FormStatus.loading),
        const LoginState(
          authMode: AuthMode.login,
          formStatus: FormStatus.error,
          errorMessage: 'Falha ao realizar login. Verifique suas credenciais.',
        ),
      ],
      verify: (_) {
        verify(mockLoginUseCase(cpf: tCpf, password: tPassword));
      },
    );

    blocTest<LoginBloc, LoginState>(
      'should emit [loading, error] when login throws FirebaseAuthException',
      build: () {
        when(mockLoginUseCase(
          cpf: anyNamed('cpf'),
          password: anyNamed('password'),
        )).thenThrow(
          FirebaseAuthException(
            code: 'user-not-found',
            message: 'No user found for that email.',
          ),
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(cpf: tCpf, password: tPassword)),
      expect: () => [
        const LoginState(authMode: AuthMode.login, formStatus: FormStatus.loading),
        predicate<LoginState>((state) => 
          state.authMode == AuthMode.login && 
          state.formStatus == FormStatus.error && 
          state.errorMessage != null
        ),
      ],
      verify: (_) {
        verify(mockLoginUseCase(cpf: tCpf, password: tPassword));
      },
    );
  });

  group('RegisterSubmitted', () {
    final tCpf = '123.456.789-00';
    final tPassword = 'password123';
    final tUserEntity = UserEntity(
      id: 'test-id',
      cpf: tCpf,
      email: 'test@email.com',
      displayName: 'Test User',
      photoUrl: null,
    );

    blocTest<LoginBloc, LoginState>(
      'should emit [loading, success] when register is successful',
      build: () {
        when(mockRegisterUseCase(
          cpf: anyNamed('cpf'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => tUserEntity);
        return loginBloc;
      },
      act: (bloc) => bloc.add(RegisterSubmitted(cpf: tCpf, password: tPassword)),
      expect: () => [
        const LoginState(authMode: AuthMode.login, formStatus: FormStatus.loading),
        const LoginState(authMode: AuthMode.login, formStatus: FormStatus.success),
      ],
      verify: (_) {
        verify(mockRegisterUseCase(cpf: tCpf, password: tPassword));
      },
    );

    blocTest<LoginBloc, LoginState>(
      'should emit [loading, error] when register fails with null user',
      build: () {
        when(mockRegisterUseCase(
          cpf: anyNamed('cpf'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => null);
        return loginBloc;
      },
      act: (bloc) => bloc.add(RegisterSubmitted(cpf: tCpf, password: tPassword)),
      expect: () => [
        const LoginState(authMode: AuthMode.login, formStatus: FormStatus.loading),
        const LoginState(
          authMode: AuthMode.login,
          formStatus: FormStatus.error,
          errorMessage: 'Falha ao criar conta. Tente novamente.',
        ),
      ],
      verify: (_) {
        verify(mockRegisterUseCase(cpf: tCpf, password: tPassword));
      },
    );
  });
}