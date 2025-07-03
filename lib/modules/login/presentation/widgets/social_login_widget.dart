import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';

const Color kYellowGreenAccent = Color(0xFFc5d94F);
const Color kGoldColor = Color.fromARGB(255, 230, 213, 60);

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logoWidth = kIsWeb ? context.wp(3.5) : context.wp(10);
    final textSize = kIsWeb ? context.hp(3) : context.hp(2.2);
    final subTextSize = kIsWeb ? context.hp(1.4) : context.hp(1.6);
    final iconSize = kIsWeb ? 40.0 : context.hp(7.5);
    final iconWidth = kIsWeb ? 40.0 : context.wp(7.5);

    final verticalSpacing = kIsWeb ? context.hp(1.5) : context.hp(2);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/client_logo/tokio_logo_icon.png',
              width: logoWidth,
            ),
            SizedBox(width: context.wp(kIsWeb ? 0.4 : 2)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'tokio',
                  style: TextStyle(fontSize: textSize, height: kIsWeb ? 0.8 : 1.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'resolve',
                  style: TextStyle(fontSize: textSize, color: kGoldColor, height: kIsWeb ? 0.8 : 1.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: verticalSpacing),
        Text(
          'Acesse através das redes sociais',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: subTextSize,
          ),
        ),
        SizedBox(height: kIsWeb ? 15.0 : 0),
        Container(
          constraints: const BoxConstraints(
            maxWidth: kIsWeb ? 360.0 : 220.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/social_media/google-white-icon.png',
                height: iconSize,
                width: iconWidth,
              ),
              Image.asset(
                'assets/images/social_media/facebook-white-icon.png',
                height: iconSize,
                width: iconWidth,
              ),
              Image.asset(
                'assets/images/social_media/twitter-white-icon.png',
                height: iconSize,
                width: iconWidth,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
