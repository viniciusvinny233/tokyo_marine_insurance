import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';

const Color kDrawerColor = Color.fromARGB(255, 27, 27, 39);

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 1050;
    final drawerWidth = kIsWeb ? (MediaQuery.of(context).size.width * (isSmallScreen ? 0.6 : 0.2)) : null;

    final menuItems = [
      {
        'title': 'Home/Seguro',
        'icon': Icons.home_outlined,
        'route': '/home',
      },
      {
        'title': 'Minhas Contratações',
        'icon': Icons.receipt_outlined,
        'route': null,
      },
      {
        'title': 'Meus Sinistros',
        'icon': Icons.car_crash_outlined,
        'route': null,
      },
      {
        'title': 'Minha Família',
        'icon': Icons.people_outline,
        'route': null,
      },
      {
        'title': 'Meus Bens',
        'icon': Icons.inventory_outlined,
        'route': null,
      },
      {
        'title': 'Pagamentos',
        'icon': Icons.payment_outlined,
        'route': null,
      },
      {
        'title': 'Coberturas',
        'icon': Icons.person_outline,
        'route': null,
      },
      {
        'title': 'Validar Boleto',
        'icon': Icons.check_circle_outline,
        'route': null,
      },
      {
        'title': 'Telefones Importantes',
        'icon': Icons.phone_outlined,
        'route': null,
      },
      {
        'title': 'Configurações',
        'icon': Icons.settings_outlined,
        'route': null,
      },
    ];

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        backgroundColor: kDrawerColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: kIsWeb ? context.hp(7.25) : context.hp(10),
                left: kIsWeb ? context.wp(1) : context.wp(4),
                right: kIsWeb ? context.wp(2) : context.wp(4),
                bottom: kIsWeb ? context.hp(1) : context.hp(2),
              ),
              color: kDrawerColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.7),
                      fontSize: kIsWeb ? context.hp(1.4) : context.hp(1.8),
                    ),
                  ),
                  SizedBox(height: kIsWeb ? context.hp(0.7) : context.hp(1)),
                  Row(
                    children: [
                      Container(
                        width: kIsWeb ? context.hp(4) : context.hp(5),
                        height: kIsWeb ? context.hp(4) : context.hp(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kMenuIconColor, width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/icon_person/avatar-man.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: kIsWeb ? context.wp(0.5) : context.wp(3)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CAIO MÁXIMO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: kIsWeb ? context.hp(2) : context.hp(2.5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Minha conta',
                                  style: TextStyle(
                                    color: kGreenLight,
                                    fontSize: kIsWeb ? context.hp(1.2) : context.hp(1.4),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: kGreenLight,
                                  size: kIsWeb ? context.hp(1.6) : context.hp(2),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kIsWeb ? 16 : 0),
              child: Divider(color: Colors.white.withOpacity(0.1), height: 1),
            ),
            kIsWeb
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return InkWell(
                        onTap: () {
                          debugPrint('${item['title']} pressed');
                          Navigator.pop(context);

                          final route = item['route'] as String?;
                          if (route != null) {
                            Modular.to.navigate(route);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.wp(1),
                            vertical: context.hp(1.2),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item['icon'] as IconData,
                                color: kMenuIconColor,
                                size: context.hp(2),
                              ),
                              SizedBox(width: context.wp(0.8)),
                              Expanded(
                                child: Text(
                                  item['title'] as String,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: context.hp(1.3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        final item = menuItems[index];
                        return InkWell(
                          onTap: () {
                            debugPrint('${item['title']} pressed');
                            Navigator.pop(context);

                            final route = item['route'] as String?;
                            if (route != null) {
                              Modular.to.navigate(route);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: context.hp(1.4),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  item['icon'] as IconData,
                                  color: kMenuIconColor,
                                  size: context.hp(2.3),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    item['title'] as String,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: context.hp(1.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            InkWell(
              onTap: () {
                debugPrint('Usuário deslogado');
                Navigator.pop(context);
                Modular.to.navigate('/');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kIsWeb ? context.wp(1) : 14,
                  vertical: kIsWeb ? context.hp(1) : context.hp(1.4),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: kGreenLight,
                      size: kIsWeb ? context.hp(2) : context.hp(2.3),
                    ),
                    SizedBox(width: kIsWeb ? context.wp(0.8) : 16),
                    Text(
                      'Sair',
                      style: TextStyle(
                        color: kGreenLight,
                        fontSize: kIsWeb ? context.hp(1.3) : context.hp(1.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!kIsWeb) SizedBox(height: context.hp(0.5)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: kIsWeb ? context.hp(0.8) : context.hp(1),
                horizontal: kIsWeb ? context.wp(3) : context.wp(5.5),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kGreenLight, kGreenDark],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: kIsWeb ? context.hp(4.5) : context.hp(6),
                    height: kIsWeb ? context.hp(4.5) : context.hp(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/icon_person/woman-icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: kIsWeb ? context.hp(0.3) : context.hp(0.5)),
                  Text(
                    'Dúvidas?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: kIsWeb ? context.hp(1.3) : context.hp(1.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Fale com a Tokyo! Contate \num de nossos atendentes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: kIsWeb ? context.hp(1.1) : context.hp(1.3),
                    ),
                  ),
                  SizedBox(height: kIsWeb ? context.hp(2.5) : context.hp(3.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
