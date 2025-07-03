import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokyo_marine_insurance/core/utils/mask_inputs.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';
import 'package:tokyo_marine_insurance/core/utils/validators.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/bloc/login_bloc.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/widgets/login_options_widget.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/widgets/login_tabs_widget.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/widgets/submit_button_widget.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';

class LoginFormCardWidget extends StatefulWidget {
  const LoginFormCardWidget({super.key});

  @override
  State<LoginFormCardWidget> createState() => _LoginFormCardWidgetState();
}

class _LoginFormCardWidgetState extends State<LoginFormCardWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _cpfController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _cpfController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _clearAllControllers() {
    _cpfController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _formKey.currentState?.reset();
  }

  void _onSubmitted() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    debugPrint('[UI]: Botão pressionado. Validado com sucesso. Enviando para o BLoC...');

    final bloc = BlocProvider.of<LoginBloc>(context);
    final state = bloc.state;

    if (state.formStatus == FormStatus.loading) return;

    if (state.authMode == AuthMode.login) {
      bloc.add(LoginSubmitted(
        cpf: _cpfController.text,
        password: _passwordController.text,
      ));
    } else {
      bloc.add(RegisterSubmitted(
        cpf: _cpfController.text,
        password: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final cardPaddingHorizontal = kIsWeb ? context.wp(2) : context.wp(6);
    final cardPaddingVertical = kIsWeb ? context.hp(2.5) : context.hp(3);
    final fieldsSpacing = kIsWeb ? context.hp(1.0) : context.hp(1.2);
    final tabsSpacing = kIsWeb ? context.hp(2.5) : context.hp(3);
    final optionsSpacing = kIsWeb ? context.hp(2.0) : context.hp(2.5);
    final bottomSpacing = kIsWeb ? context.hp(2.1) : context.hp(1);
    final buttonOffset = kIsWeb ? context.hp(4) : context.hp(5);

    double fieldsSpacingMultiplier;

    if (screenHeight <= 650) {
      fieldsSpacingMultiplier = 1.8;
    } else if (screenHeight <= 800) {
      fieldsSpacingMultiplier = 3.0;
    } else {
      fieldsSpacingMultiplier = 3.0 - (screenHeight - 800) / 400;
      fieldsSpacingMultiplier = fieldsSpacingMultiplier.clamp(1.0, 3.0);
    }

    if (kIsWeb) {
      fieldsSpacingMultiplier = (fieldsSpacingMultiplier * 0.7).clamp(1.0, 2.5);
    }

    final adaptiveFieldsSpacing = fieldsSpacing * fieldsSpacingMultiplier;

    const cardBorderRadius = kIsWeb ? 8.0 : 10.0;

    const cardMaxWidth = kIsWeb ? 520.0 : double.infinity;
    const cardMaxHeight = kIsWeb ? 800.0 : double.infinity;

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.authMode != current.authMode,
      listener: (context, state) {
        _clearAllControllers();
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isRegisterMode = state.authMode == AuthMode.register;
          final double cardHeight;
          if (kIsWeb) {
            cardHeight = isRegisterMode ? 390.0 : 330.0;
          } else {
            if (screenHeight <= 650) {
              cardHeight = isRegisterMode ? 280.0 : 180.0;
            } else if (screenHeight <= 800) {
              cardHeight = isRegisterMode ? 300.0 : 215.0;
            } else {
              cardHeight = isRegisterMode ? 350.0 : 310.0;
            }
          }

          final loginOptionsSpacing = isRegisterMode ? context.hp(kIsWeb ? 0.8 : 1.0) : optionsSpacing;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            constraints: BoxConstraints(
              maxWidth: cardMaxWidth,
              minHeight: cardHeight,
              maxHeight: cardMaxHeight,
            ),
            decoration: BoxDecoration(
              color: kCardColor,
              borderRadius: BorderRadius.circular(cardBorderRadius),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: cardPaddingHorizontal,
                    vertical: cardPaddingVertical,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LoginTabsWidget(),
                        SizedBox(height: tabsSpacing),
                        _buildTextField(context, hintText: 'CPF', controller: _cpfController, keyboardType: TextInputType.number, inputFormatters: [CpfInputFormatter()], validator: Validators.validateCpf),
                        SizedBox(height: adaptiveFieldsSpacing * (kIsWeb ? 1.5 : 0.5)),
                        _buildTextField(context, hintText: 'Senha', controller: _passwordController, obscureText: true, validator: Validators.validatePassword),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Column(
                            children: [
                              SizedBox(
                                height: isRegisterMode ? null : 0,
                                child: ClipRect(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: (Widget child, Animation<double> animation) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.0, -1.0),
                                          end: const Offset(0.0, 0.0),
                                        ).animate(CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeOutBack,
                                          reverseCurve: Curves.easeInBack,
                                        )),
                                        child: FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: isRegisterMode
                                        ? Column(
                                            key: const ValueKey('confirm_password_field'),
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(height: adaptiveFieldsSpacing * (kIsWeb ? 1.5 : 0.5)),
                                              _buildTextField(
                                                context, 
                                                hintText: 'Confirmar Senha', 
                                                controller: _confirmPasswordController, 
                                                obscureText: true, 
                                                validator: (value) => Validators.validateConfirmPassword(value, _passwordController.text)
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(key: ValueKey('empty')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: loginOptionsSpacing,
                        ),
                        ClipRect(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, 1.0),
                                  end: const Offset(0.0, 0.0),
                                ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutBack,
                                  reverseCurve: Curves.easeInBack,
                                )),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: !isRegisterMode
                                ? Container(
                                    key: const ValueKey('login_options'),
                                    child: const LoginOptionsWidget(),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0),
                                    child: SizedBox.shrink(key: ValueKey('empty_options')),
                                  ),
                          ),
                        ),
                        SizedBox(height: bottomSpacing * 2),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -buttonOffset,
                  child: SubmitButtonWidget(onPressed: _onSubmitted),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(BuildContext context,
      {required String hintText,
      required TextEditingController controller,
      bool obscureText = false,
      List<TextInputFormatter>? inputFormatters,
      TextInputType? keyboardType,
      String? Function(String?)? validator}) {
    final fieldPadding = kIsWeb ? context.hp(1.8) : context.hp(2.2);
    final textSize = kIsWeb ? context.hp(1.6) : null;

    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Colors.white,
          fontSize: textSize,
        );

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      style: textStyle,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: fieldPadding),
      ),
    );
  }
}