import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';
import 'package:tokyo_marine_insurance/modules/login/presentation/bloc/login_bloc.dart';

class LoginTabsWidget extends StatelessWidget {
  const LoginTabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final tabSpacing = kIsWeb ? context.wp(1.5) : context.wp(5);

        return Row(
          children: [
            _buildTab(context, 'Entrar', AuthMode.login, state.authMode == AuthMode.login),
            SizedBox(width: tabSpacing),
            _buildTab(context, 'Cadastrar', AuthMode.register, state.authMode == AuthMode.register),
          ],
        );
      },
    );
  }

  Widget _buildTab(BuildContext context, String text, AuthMode mode, bool isActive) {
    final fontSize = kIsWeb ? context.hp(1.7) : context.hp(2);
    const underlineHeight = kIsWeb ? 2.5 : 3.0;

    final baseStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: fontSize,
        );

    final activeStyle = baseStyle?.copyWith(
          color: kGreenAccent,
          fontWeight: FontWeight.bold,
        ) ??
        const TextStyle();

    final inactiveStyle = baseStyle?.copyWith(
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.bold,
        ) ??
        const TextStyle();

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: activeStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return GestureDetector(
      onTap: () {
        BlocProvider.of<LoginBloc>(context).add(LoginTabChanged(mode));
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: isActive ? activeStyle : inactiveStyle,
            child: Text(text),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: underlineHeight,
            width: isActive ? textPainter.width : 0,
            decoration: BoxDecoration(
              color: kGreenAccent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
