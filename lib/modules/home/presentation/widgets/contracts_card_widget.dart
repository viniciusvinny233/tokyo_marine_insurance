import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';

class ContractsCardWidget extends StatelessWidget {
  const ContractsCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = kIsWeb ? context.hp(15) : context.hp(23);
    final iconSize = kIsWeb ? context.hp(4) : context.hp(8);
    final textSize = kIsWeb ? context.hp(1.4) : context.hp(1.5);

    return Container(
      height: cardHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied_rounded,
            color: Colors.white.withOpacity(0.7),
            size: iconSize,
          ),
          SizedBox(height: context.hp(1.5)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
            child: Text(
              'Você ainda não possui seguros contratados.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: textSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
