import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tokyo_marine_insurance/modules/login/data/repositories/auth_repository_impl.dart';
import 'package:tokyo_marine_insurance/modules/login/data/services/auth_service.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/entities/user_entity.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthService, User])
void main() {
  late AuthRepositoryImpl authRepository;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    authRepository = AuthRepositoryImpl(authService: mockAuthService);
  });

  group('login', () {
    const tCpf = '123.456.789-00';
    const tPassword = 'password123';
    final tUser = MockUser();

    setUp(() {
      when(tUser.uid).thenReturn('test-uid');
      when(tUser.email).thenReturn('test@email.com');
      when(tUser.displayName).thenReturn('Test User');
      when(tUser.photoURL).thenReturn(null);
    });

    test('should return UserEntity when login is successful', () async {
      when(mockAuthService.signInWithEmailAndPassword(
        cpf: anyNamed('cpf'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => tUser);

      final result = await authRepository.login(cpf: tCpf, password: tPassword);

      expect(result, isA<UserEntity>());
      expect(result?.id, equals('test-uid'));
      expect(result?.cpf, equals(tCpf));
      expect(result?.email, equals('test@email.com'));
      expect(result?.displayName, equals('Test User'));
      expect(result?.photoUrl, isNull);
      verify(mockAuthService.signInWithEmailAndPassword(cpf: tCpf, password: tPassword));
    });

    test('should return null when login fails', () async {
      when(mockAuthService.signInWithEmailAndPassword(
        cpf: anyNamed('cpf'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => null);

      final result = await authRepository.login(cpf: tCpf, password: tPassword);

      expect(result, isNull);
      verify(mockAuthService.signInWithEmailAndPassword(cpf: tCpf, password: tPassword));
    });
  });

  group('register', () {
    const tCpf = '123.456.789-00';
    const tPassword = 'password123';
    final tUser = MockUser();

    setUp(() {
      when(tUser.uid).thenReturn('test-uid');
      when(tUser.email).thenReturn('test@email.com');
      when(tUser.displayName).thenReturn('Test User');
      when(tUser.photoURL).thenReturn(null);
    });

    test('should return UserEntity when register is successful', () async {
      when(mockAuthService.createUserWithEmailAndPassword(
        cpf: anyNamed('cpf'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => tUser);

      final result = await authRepository.register(cpf: tCpf, password: tPassword);

      expect(result, isA<UserEntity>());
      expect(result?.id, equals('test-uid'));
      expect(result?.cpf, equals(tCpf));
      verify(mockAuthService.createUserWithEmailAndPassword(cpf: tCpf, password: tPassword));
    });

    test('should return null when register fails', () async {
      when(mockAuthService.createUserWithEmailAndPassword(
        cpf: anyNamed('cpf'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => null);

      final result = await authRepository.register(cpf: tCpf, password: tPassword);

      expect(result, isNull);
      verify(mockAuthService.createUserWithEmailAndPassword(cpf: tCpf, password: tPassword));
    });
  });

  group('logout', () {
    test('should call signOut from authService', () async {
      when(mockAuthService.signOut()).thenAnswer((_) async => {});

      await authRepository.logout();

      verify(mockAuthService.signOut());
    });
  });

  group('getCurrentUser', () {
    test('should return null when there is no current user', () async {
      when(mockAuthService.getCurrentUser()).thenReturn(null);

      final result = await authRepository.getCurrentUser();

      expect(result, isNull);
      verify(mockAuthService.getCurrentUser());
    });

    test('should return UserEntity when there is a current user and lastUsedCpf', () async {
      final tUser = MockUser();
      when(tUser.uid).thenReturn('test-uid');
      when(tUser.email).thenReturn('test@email.com');
      when(tUser.displayName).thenReturn('Test User');
      when(tUser.photoURL).thenReturn(null);

      when(mockAuthService.getCurrentUser()).thenReturn(tUser);

      when(mockAuthService.signInWithEmailAndPassword(
        cpf: anyNamed('cpf'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => tUser);

      await authRepository.login(cpf: '123.456.789-00', password: 'password123');

      final result = await authRepository.getCurrentUser();

      expect(result, isA<UserEntity>());
      expect(result?.id, equals('test-uid'));
      expect(result?.cpf, equals('123.456.789-00'));
    });
  });
}
