import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';

class FamilyCardWidget extends StatelessWidget {
  const FamilyCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = kIsWeb ? context.hp(15) : context.hp(23);
    final iconSize = kIsWeb ? context.hp(4) : context.hp(4);
    final textSize = kIsWeb ? context.hp(1.4) : context.hp(1.5);

    return Container(
      height: cardHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            debugPrint('Family card pressed');
          },
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: iconSize * 1.5,
                height: iconSize * 1.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
              SizedBox(height: context.hp(1.5)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
                child: Text(
                  'Adicione aqui membros da sua família e compartilhe os seguros com eles.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: textSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
