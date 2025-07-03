import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/bloc/login_bloc.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';

class SubmitButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const SubmitButtonWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    const buttonSizePercent = kIsWeb ? 8.0 : 10.0;
    final buttonSize = context.hp(buttonSizePercent);
    const borderSize = kIsWeb ? 7.0 : 9.0;
    const iconSizePercent = kIsWeb ? 0.4 : 0.45;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: const BoxDecoration(
          color: kCardColor,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(borderSize),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [kGreenLight, kGreenDark], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.5, 2.0]),
          ),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state.formStatus == FormStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: kIsWeb ? 2.5 : 3.0,
                  ),
                );
              }

              final icon = state.authMode == AuthMode.login ? Icons.arrow_forward_rounded : Icons.person_add_alt_1_rounded;
              return Center(
                child: Icon(icon, color: Colors.white, size: buttonSize * iconSizePercent),
              );
            },
          ),
        ),
      ),
    );
  }
}
