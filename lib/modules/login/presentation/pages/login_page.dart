import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/bloc/login_bloc.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/widgets/header_widget.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/widgets/login_form_card_widget.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/widgets/social_login_widget.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/widgets/success_modal_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<LoginBloc>(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.success && state.authMode == AuthMode.register) {
            _showSuccessDialog(context);
          } else if (state.formStatus == FormStatus.success && state.authMode == AuthMode.login) {
            try {
              Modular.to.navigate('/home');
            } catch (e) {
              debugPrint('Erro de navegação: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login bem-sucedido!')),
              );
            }
          }
          if (state.formStatus == FormStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'Ocorreu um erro.')),
              );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(builder: (context, constraints) {
            if (!kIsWeb) {
              return _buildMobileLayout(context);
            } else {
              return _buildWebLayout(context, constraints);
            }
          }),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Modal",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SuccessModalWidget(),
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pop();

      BlocProvider.of<LoginBloc>(context).add(const LoginTabChanged(AuthMode.login));
    });
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kGreenLight, kGreenDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.15, 0.5],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(height: context.height * 0.5, color: kPrimaryColor),
            ),
          ],
        ),
        SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 470),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          final bool isRegisterMode = state.authMode == AuthMode.register;

                          final int topFlex = isRegisterMode ? 20 : 25;
                          final int middleFlex = isRegisterMode ? 51 : 50;
                          final int bottomFlex = isRegisterMode ? 21 : 25;

                          final int totalFlex = topFlex + middleFlex + bottomFlex;

                          final double topHeight = constraints.maxHeight * (topFlex / totalFlex);
                          final double middleHeight = constraints.maxHeight * (middleFlex / totalFlex);
                          final double bottomHeight = constraints.maxHeight * (bottomFlex / totalFlex);

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                height: topHeight,
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: context.wp(4.5)),
                                  child: const HeaderWidget(),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                height: middleHeight,
                                alignment: Alignment.topCenter,
                                padding: const EdgeInsets.only(top: 15),
                                child: const LoginFormCardWidget(),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                height: bottomHeight,
                                alignment: Alignment.topCenter,
                                padding: const EdgeInsets.only(top: 20),
                                child: const SocialLoginWidget(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWebLayout(BuildContext context, BoxConstraints constraints) {
    final formCardWidth = constraints.maxWidth * 0.2;
    const formCardMaxWidth = 670.0;
    const formCardMinWidth = 520.0;

    final isSmallScreen = constraints.maxWidth < 600;

    final adjustedMinWidth = isSmallScreen ? 370.0 : formCardMinWidth;

    final finalFormWidth = formCardWidth.clamp(adjustedMinWidth, formCardMaxWidth);

    final headerScale = constraints.maxWidth < 1200 ? 0.85 : 1.0;
    final socialLoginScale = constraints.maxWidth < 1200 ? 0.7 : 0.8;

    return Stack(
      children: [
        Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kGreenLight, kGreenDark],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.35, 1],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(height: constraints.maxHeight * 0.5, color: kPrimaryColor),
            ),
          ],
        ),
        SafeArea(
          child: LayoutBuilder(
            builder: (context, layoutConstraints) {
              return Center(
                child: SizedBox(
                  height: layoutConstraints.maxHeight,
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      final bool isRegisterMode = state.authMode == AuthMode.register;

                      final int topFlex = isRegisterMode ? 20 : 20;
                      final int middleFlex = isRegisterMode ? 60 : 60;
                      final int bottomFlex = isRegisterMode ? 20 : 20;

                      final int totalFlex = topFlex + middleFlex + bottomFlex;

                      final double topHeight = layoutConstraints.maxHeight * (topFlex / totalFlex);
                      final double middleHeight = layoutConstraints.maxHeight * (middleFlex / totalFlex);
                      final double bottomHeight = layoutConstraints.maxHeight * (bottomFlex / totalFlex);

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            height: topHeight,
                            width: double.infinity,
                            child: Center(
                              child: SizedBox(
                                width: finalFormWidth * 1.5,
                                child: Transform.scale(
                                  scale: headerScale,
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: topHeight * 0.15),
                                    child: const HeaderWidget(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            height: middleHeight,
                            alignment: Alignment.center,
                            child: Container(
                              width: finalFormWidth,
                              padding: const EdgeInsets.symmetric(horizontal: kIsWeb ? 10 : 0),
                              child: const LoginFormCardWidget(),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            height: bottomHeight,
                            alignment: Alignment.topCenter,
                            child: Transform.scale(
                              scale: socialLoginScale,
                              child: const SizedBox(
                                child: SocialLoginWidget(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
