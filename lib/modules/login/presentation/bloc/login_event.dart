part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginTabChanged extends LoginEvent {
  final AuthMode authMode;

  const LoginTabChanged(this.authMode);

  @override
  List<Object> get props => [authMode];
}

class LoginSubmitted extends LoginEvent {
  final String cpf;
  final String password;

  const LoginSubmitted({required this.cpf, required this.password});

  @override
  List<Object> get props => [cpf, password];
}

class RegisterSubmitted extends LoginEvent {
  final String cpf;
  final String password;

  const RegisterSubmitted({required this.cpf, required this.password});

  @override
  List<Object> get props => [cpf, password];
}
