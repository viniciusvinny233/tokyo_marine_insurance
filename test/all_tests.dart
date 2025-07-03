import 'package:flutter_test/flutter_test.dart';

import 'core/utils/validators_test.dart' as validators_test;
import 'core/utils/responsive_helper_test.dart' as responsive_helper_test;

import 'modules/login/domain/usecases/login_usecase_test.dart' as login_usecase_test;
import 'modules/login/domain/usecases/register_usecase_test.dart' as register_usecase_test;
import 'modules/login/data/repositories/auth_repository_impl_test.dart' as auth_repository_impl_test;
import 'modules/login/presentation/bloc/login_bloc_test.dart' as login_bloc_test;
import 'modules/login/presentation/widgets/login_form_card_widget_test.dart' as login_form_card_widget_test;

import 'modules/home/presentation/bloc/home_bloc_test.dart' as home_bloc_test;
import 'modules/home/presentation/widgets/insurance_grid_widget_test.dart' as insurance_grid_widget_test;
import 'modules/home/presentation/widgets/family_card_widget_test.dart' as family_card_widget_test;
import 'modules/home/presentation/widgets/contracts_card_widget_test.dart' as contracts_card_widget_test;

import 'integration_tests/login_flow_test.dart' as login_flow_test;

void main() {
  group('Core Tests', () {
    validators_test.main();
    responsive_helper_test.main();
  });

  group('Login Module Tests', () {
    login_usecase_test.main();
    register_usecase_test.main();
    auth_repository_impl_test.main();
    login_bloc_test.main();
    login_form_card_widget_test.main();
  });

  group('Home Module Tests', () {
    home_bloc_test.main();
    insurance_grid_widget_test.main();
    family_card_widget_test.main();
    contracts_card_widget_test.main();
  });

  group('Integration Tests', () {
    login_flow_test.main();
  });
}