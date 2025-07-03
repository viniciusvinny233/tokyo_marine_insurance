import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_marine_insurance/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateCpf', () {
      test('should return error message when CPF is null', () {
        final result = Validators.validateCpf(null);
        expect(result, 'Por favor, insira seu CPF.');
      });

      test('should return error message when CPF is empty', () {
        final result = Validators.validateCpf('');
        expect(result, 'Por favor, insira seu CPF.');
      });

      test('should return error message when CPF has less than 11 digits', () {
        final result = Validators.validateCpf('123.456.789');
        expect(result, 'CPF inválido. Deve conter 11 dígitos.');
      });

      test('should return null when CPF is valid with formatting', () {
        final result = Validators.validateCpf('123.456.789-00');
        expect(result, null);
      });

      test('should return null when CPF is valid without formatting', () {
        final result = Validators.validateCpf('12345678900');
        expect(result, null);
      });
    });

    group('validatePassword', () {
      test('should return error message when password is null', () {
        final result = Validators.validatePassword(null);
        expect(result, 'Por favor, insira sua senha.');
      });

      test('should return error message when password is empty', () {
        final result = Validators.validatePassword('');
        expect(result, 'Por favor, insira sua senha.');
      });

      test('should return error message when password is less than 6 characters', () {
        final result = Validators.validatePassword('12345');
        expect(result, 'A senha deve ter no mínimo 6 caracteres.');
      });

      test('should return null when password is valid', () {
        final result = Validators.validatePassword('123456');
        expect(result, null);
      });
    });

    group('validateConfirmPassword', () {
      test('should return error message when passwords do not match', () {
        final result = Validators.validateConfirmPassword('123456', '1234567');
        expect(result, 'As senhas não coincidem.');
      });

      test('should return null when passwords match', () {
        final result = Validators.validateConfirmPassword('123456', '123456');
        expect(result, null);
      });
    });
  });
}