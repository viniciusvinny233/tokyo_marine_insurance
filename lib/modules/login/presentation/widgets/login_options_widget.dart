import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';

class LoginOptionsWidget extends StatefulWidget {
  const LoginOptionsWidget({super.key});

  @override
  State<LoginOptionsWidget> createState() => _LoginOptionsWidgetState();
}

class _LoginOptionsWidgetState extends State<LoginOptionsWidget> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    const checkboxSize = kIsWeb ? 22.0 : 25.0;
    const checkboxMargin = kIsWeb ? 6.0 : 8.0;
    const checkIconSize = kIsWeb ? 14.0 : 16.0;
    final textSize = kIsWeb ? context.hp(1.4) : context.hp(1.6);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isChecked = !_isChecked;
            });
          },
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: checkboxSize,
                height: checkboxSize,
                margin: const EdgeInsets.only(right: checkboxMargin),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isChecked ? kGreenAccent : Colors.transparent,
                  border: Border.all(
                    color: _isChecked ? kGreenAccent : Colors.grey,
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: _isChecked
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: checkIconSize,
                          key: ValueKey('checked_icon'),
                        )
                      : const SizedBox(
                          key: ValueKey('unchecked_icon'),
                        ),
                ),
              ),
              const SizedBox(
                height: kIsWeb ? 60 : 0,
              ),
              Text(
                'Lembrar Sempre',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          child: Text(
            'Esqueceu a senha?',
            style: TextStyle(
              color: kGreenAccent,
              fontSize: textSize,
            ),
          ),
        ),
      ],
    );
  }
}
