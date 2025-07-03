import 'package:flutter_modular/flutter_modular.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/bloc/home_bloc.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/pages/home_page.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/pages/insurance_webview_screen.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HomeBloc()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage()),
        ChildRoute(
          '/insurance-webview',
          child: (_, args) => InsuranceWebViewScreen(
            title: args.data['title'],
            url: args.data['url'],
          ),
        ),
      ];
}
