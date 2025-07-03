import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokyo_marine_insurance/modules/home/domain/models/user_model.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/bloc/home_event.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<LoadUserDataEvent>(_onLoadUserData);
    on<LogoutEvent>(_onLogout);
  }

  void _onLoadUserData(LoadUserDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      final user = UserModel(
        name: 'Caio Máximo',
        avatarUrl: 'assets/images/avatar-man.png',
      );
      
      emit(HomeLoadedState(
        userName: user.name,
        avatarUrl: user.avatarUrl,
      ));
    } catch (e) {
      emit(HomeErrorState(message: 'Erro ao carregar dados do usuário'));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitialState());
  }
}