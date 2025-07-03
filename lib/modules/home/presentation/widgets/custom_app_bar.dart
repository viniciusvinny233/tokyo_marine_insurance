import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logoHeight = kIsWeb ? context.hp(3) : context.hp(3);
    final iconSize = kIsWeb ? context.hp(2.2) : context.hp(2.8);

    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/images/icon_appbar/menu-icon.svg',
          width: iconSize,
          height: iconSize,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: GestureDetector(
        onTap: () {
          Modular.to.navigate('/home');
        },
        child: Image.asset(
          'assets/images/client_logo/tokio_logo_branco.png',
          height: logoHeight,
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/images/icon_appbar/notification-icon.svg',
                width: iconSize,
                height: iconSize,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              onPressed: () {
                debugPrint('Notifications pressed');
              },
            ),
            Positioned(
              top: kIsWeb ? 6 : 10,
              right: kIsWeb ? 10 : 5.5,
              child: Container(
                width: kIsWeb ? 10 : 15,
                height: kIsWeb ? 10 : 15,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: context.wp(1)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
