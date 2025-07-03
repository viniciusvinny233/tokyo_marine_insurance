import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logoHeight = kIsWeb ? context.hp(3.5) : context.hp(10);
    final logoWidth = kIsWeb ? context.wp(25) : context.wp(35);
    final titleSize = kIsWeb ? context.hp(2.0) : context.hp(2.4);
    final subtitleSize = kIsWeb ? context.hp(1.3) : context.hp(1.5);

    return Column(
      crossAxisAlignment: kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/client_logo/tokio_logo_branco.png',
          height: logoHeight,
          width: logoWidth,
        ),
        SizedBox(height: context.hp(kIsWeb ? 1.5 : 0)),
        Text(
          'Bem vindo!',
          textAlign: kIsWeb ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.hp(0.8)),
        Text(
          'Aqui você gerencia seus seguros e de seus familiares em poucos cliques!',
          textAlign: kIsWeb ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: subtitleSize,
          ),
        ),
      ],
    );
  }
}
