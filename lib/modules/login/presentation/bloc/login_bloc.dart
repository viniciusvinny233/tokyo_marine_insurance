import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tokyo_marine_insurance/core/utils/firebase_error_translator.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/login_usecase.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/register_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  LoginBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        super(const LoginState()) {
    on<LoginTabChanged>(_onTabChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  void _onTabChanged(LoginTabChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(authMode: event.authMode, formStatus: FormStatus.initial));
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      final user = await _loginUseCase(cpf: event.cpf, password: event.password);
      if (user != null) {
        emit(state.copyWith(formStatus: FormStatus.success));
      } else {
        emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: 'Falha ao realizar login. Verifique suas credenciais.',
        ));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('[BLoC-ERRO]: Erro do Firebase ao logar: ${e.code} - ${e.message}');
      final String translatedMessage = FirebaseErrorTranslator.translateError(e);
      emit(state.copyWith(formStatus: FormStatus.error, errorMessage: translatedMessage));
    } catch (e) {
      debugPrint('[BLoC-ERRO]: Erro inesperado ao logar: $e');
      emit(state.copyWith(formStatus: FormStatus.error, errorMessage: 'Ocorreu um erro inesperado.'));
    }
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      final user = await _registerUseCase(cpf: event.cpf, password: event.password);
      if (user != null) {
        emit(state.copyWith(formStatus: FormStatus.success));
      } else {
        emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: 'Falha ao criar conta. Tente novamente.',
        ));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('[BLoC-ERRO]: Erro do Firebase ao registrar: ${e.code} - ${e.message}');
      final String translatedMessage = FirebaseErrorTranslator.translateError(e);
      emit(state.copyWith(formStatus: FormStatus.error, errorMessage: translatedMessage));
    } catch (e) {
      debugPrint('[BLoC-ERRO]: Erro inesperado ao registrar: $e');
      emit(state.copyWith(formStatus: FormStatus.error, errorMessage: 'Ocorreu um erro inesperado.'));
    }
  }
}