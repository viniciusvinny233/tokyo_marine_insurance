import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';

class SuccessModalWidget extends StatefulWidget {
  const SuccessModalWidget({super.key});

  @override
  State<SuccessModalWidget> createState() => _SuccessModalWidgetState();
}

class _SuccessModalWidgetState extends State<SuccessModalWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _iconScaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final containerWidth = kIsWeb ? context.wp(30).clamp(350.0, 450.0) : double.infinity;

    const iconSizePercent = kIsWeb ? 5.0 : 6.5;
    final iconSize = context.hp(iconSizePercent);

    const iconPaddingPercent = kIsWeb ? 1.2 : 1.5;
    final iconPadding = context.hp(iconPaddingPercent);

    const containerPaddingHorizPercent = kIsWeb ? 2.0 : 2.5;
    const containerPaddingVertPercent = kIsWeb ? 4.0 : 2.5;
    final containerPadding = EdgeInsets.symmetric(
      horizontal: context.wp(containerPaddingHorizPercent),
      vertical: context.hp(containerPaddingVertPercent),
    );

    final borderRadiusSize = context.wp(kIsWeb ? 1.2 : 3);

    final titleFontSize = kIsWeb ? context.hp(2.2).clamp(18.0, 24.0) : context.hp(2.5).clamp(18.0, 22.0);

    final subtitleFontSize = kIsWeb ? context.hp(1.8).clamp(14.0, 18.0) : context.hp(2.0).clamp(14.0, 16.0);

    final spacingHeight = context.hp(kIsWeb ? 1.5 : 2.0);
    final smallSpacingHeight = context.hp(kIsWeb ? 1.0 : 1.5);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.wp(kIsWeb ? 3.0 : 5.0),
        vertical: context.hp(kIsWeb ? 3.0 : 4.0),
      ),
      child: Container(
        width: containerWidth,
        padding: containerPadding,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(borderRadiusSize),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _iconScaleAnimation,
              child: Container(
                width: iconSize,
                height: iconSize,
                padding: EdgeInsets.all(iconPadding),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [kGreenLight, kGreenDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: iconSize * 0.5,
                ),
              ),
            ),
            SizedBox(height: spacingHeight),
            FadeTransition(
              opacity: _opacityAnimation,
              child: Text(
                'Conta criada com sucesso!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: smallSpacingHeight),
            FadeTransition(
              opacity: _opacityAnimation,
              child: Text(
                'Você será redirecionado para o login em instantes...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: subtitleFontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
