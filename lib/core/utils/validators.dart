class Validators {
  static String? validateCpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu CPF.';
    }
    final unformattedCpf = value.replaceAll(RegExp(r'[^\d]'), '');
    if (unformattedCpf.length != 11) {
      return 'CPF inválido. Deve conter 11 dígitos.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha.';
    }
    if (value.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres.';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value != password) {
      return 'As senhas não coincidem.';
    }
    return null;
  }
}