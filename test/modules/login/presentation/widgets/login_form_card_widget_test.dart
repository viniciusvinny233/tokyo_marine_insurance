import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/bloc/login_bloc.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/widgets/login_form_card_widget.dart';

import 'login_form_card_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginBloc>()])
void main() {
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
  });

  testWidgets('LoginFormCardWidget should render', (WidgetTester tester) async {
    when(mockLoginBloc.state).thenReturn(const LoginState(authMode: AuthMode.login));
    when(mockLoginBloc.stream).thenAnswer((_) => Stream.value(const LoginState(authMode: AuthMode.login)));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<LoginBloc>.value(
            value: mockLoginBloc,
            child: const LoginFormCardWidget(),
          ),
        ),
      ),
    );

    expect(find.byType(LoginFormCardWidget), findsOneWidget);
  });
}
