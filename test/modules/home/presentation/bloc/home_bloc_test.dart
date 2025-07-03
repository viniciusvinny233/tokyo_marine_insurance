import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/bloc/home_bloc.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/bloc/home_event.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/bloc/home_state.dart';

void main() {
  late HomeBloc homeBloc;

  setUp(() {
    homeBloc = HomeBloc();
  });

  tearDown(() {
    homeBloc.close();
  });

  test('initial state should be HomeInitialState', () {
    expect(homeBloc.state, isA<HomeInitialState>());
  });

  blocTest<HomeBloc, HomeState>(
    'should emit [HomeLoadingState, HomeLoadedState] when LoadUserDataEvent is added',
    build: () => homeBloc,
    act: (bloc) => bloc.add(LoadUserDataEvent()),
    wait: const Duration(milliseconds: 350),
    expect: () => [
      isA<HomeLoadingState>(),
      isA<HomeLoadedState>().having(
        (state) => state.userName,
        'userName',
        'Caio Máximo',
      ).having(
        (state) => state.avatarUrl,
        'avatarUrl',
        'assets/images/avatar-man.png',
      ),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'should emit [HomeInitialState] when LogoutEvent is added',
    build: () => homeBloc,
    act: (bloc) => bloc.add(LogoutEvent()),
    expect: () => [
      isA<HomeInitialState>(),
    ],
  );
}