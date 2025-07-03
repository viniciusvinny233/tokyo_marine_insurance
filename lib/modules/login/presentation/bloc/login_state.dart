part of 'login_bloc.dart';

enum AuthMode { login, register }

enum FormStatus { initial, loading, success, error }

class LoginState extends Equatable {
  final AuthMode authMode;
  final FormStatus formStatus;
  final String? errorMessage;

  const LoginState({
    this.authMode = AuthMode.login,
    this.formStatus = FormStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    AuthMode? authMode,
    FormStatus? formStatus,
    String? errorMessage,
  }) {
    return LoginState(authMode: authMode ?? this.authMode, formStatus: formStatus ?? this.formStatus, errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [authMode, formStatus, errorMessage];
}
