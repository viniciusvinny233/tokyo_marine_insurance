import 'package:flutter_modular/flutter_modular.dart';
import 'package:tokyo_marine_insurance/modules/login/data/repositories/auth_repository_impl.dart';
import 'package:tokyo_marine_insurance/modules/login/data/services/auth_service.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/repositories/auth_repository.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/login_usecase.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/register_usecase.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/bloc/login_bloc.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/pages/login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthService>((i) => AuthService()),
        Bind.lazySingleton<AuthRepository>(
          (i) => AuthRepositoryImpl(authService: i()),
        ),
        Bind.lazySingleton<LoginUseCase>((i) => LoginUseCase(i())),
        Bind.lazySingleton<RegisterUseCase>((i) => RegisterUseCase(i())),
        Bind.factory<LoginBloc>(
          (i) => LoginBloc(
            loginUseCase: i(),
            registerUseCase: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const LoginPage()),
      ];
}
