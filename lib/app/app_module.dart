import 'package:flutter_modular/flutter_modular.dart';
import 'package:tokyo_marine_insurance/core/guards/auth_guard.dart';
import 'package:tokyo_marine_insurance/modules/login/login_module.dart';
import 'package:tokyo_marine_insurance/modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule(), transition: TransitionType.fadeIn, guards: [AuthGuard()]),
      ];
}
