import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';

class WelcomeBannerWidget extends StatelessWidget {
  const WelcomeBannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bannerHeight = kIsWeb ? context.hp(9.5) : context.hp(9);
    final avatarSize = kIsWeb ? context.hp(6) : context.hp(5.5);
    final welcomeTextSize = kIsWeb ? context.hp(1.6) : context.hp(1.4);
    final nameTextSize = context.hp(2.2);

    final contentPadding = EdgeInsets.symmetric(
      horizontal: kIsWeb ? context.wp(1) : context.wp(4),
      vertical: kIsWeb ? context.hp(1.5) : context.hp(1.2),
    );

    return Container(
      height: bannerHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kGreenLight, kGreenDark],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: contentPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: double.infinity,
          ),
          child: Row(
            children: [
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/icon_person/avatar-man.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: kIsWeb ? context.wp(1) : context.wp(3)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem-vindo',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: welcomeTextSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: kIsWeb ? context.hp(0.0) : context.hp(0.5)),
                  Text(
                    'Caio Máximo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: nameTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
