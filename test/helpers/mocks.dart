import 'package:flutter_modular/flutter_modular.dart';
import 'package:mockito/annotations.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/login_usecase.dart';
import 'package:tokyo_marine_insurance/modules/login/domain/usecases/register_usecase.dart';

@GenerateMocks([
  LoginUseCase,
  RegisterUseCase,
  IModularNavigator,
])
void main() {}