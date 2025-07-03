import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/pages/insurance_webview_screen.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class InsuranceGridWidget extends StatelessWidget {
  const InsuranceGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final insuranceOptions = [
      {
        'title': 'Automóvel',
        'icon': Icons.directions_car_outlined,
        'color': Colors.blue,
      },
      {
        'title': 'Residência',
        'icon': Icons.home_outlined,
        'color': Colors.green,
      },
      {
        'title': 'Vida',
        'icon': Icons.favorite_border,
        'color': Colors.red,
      },
      {
        'title': 'Acidentes Pessoais',
        'icon': Icons.medical_services_outlined,
        'color': Colors.purple,
      },
      {
        'title': 'Empresarial',
        'icon': Icons.business_outlined,
        'color': Colors.orange,
      },
      {
        'title': 'Viagem',
        'icon': Icons.flight_outlined,
        'color': Colors.teal,
      },
    ];

    final cardWidth = kIsWeb ? 130.0 : context.wp(27);
    final cardHeight = kIsWeb ? 130.0 : context.hp(11);

    return SizedBox(
      height: cardHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: kIsWeb ? context.wp(1) : context.wp(4),
              ),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: insuranceOptions.length,
              itemBuilder: (context, index) {
                final option = insuranceOptions[index];
                return Container(
                  margin: EdgeInsets.only(
                    right: index < insuranceOptions.length - 1
                        ? kIsWeb
                            ? 2
                            : context.wp(0)
                        : 0,
                  ),
                  width: cardWidth,
                  height: cardHeight,
                  child: _buildInsuranceCard(
                    context,
                    title: option['title'] as String,
                    icon: option['icon'] as IconData,
                    color: option['color'] as Color,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    final cardPadding = EdgeInsets.symmetric(
      horizontal: kIsWeb ? 10.0 : context.wp(0.2),
      vertical: kIsWeb ? 10.0 : 0,
    );
    final iconSize = kIsWeb ? 30.0 : context.hp(3);
    final fontSize = kIsWeb ? 14.0 : context.hp(1.25);

    return Card(
      color: kCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          debugPrint('$title card pressed');
          if (title == 'Automóvel') {
            const url = 'https://portalparceiros.tokiomarine.com.br/sin/tokio-sinistro-view/';

            _launchUrl(context, url, title);
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: cardPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(kIsWeb ? 5.0 : context.hp(0.4)),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: color,
                ),
              ),
              SizedBox(height: kIsWeb ? 15.0 : context.hp(1)),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(BuildContext context, String url, String title) async {
    if (kIsWeb) {
      final Uri uri = Uri.parse(url);
      if (await url_launcher.canLaunchUrl(uri)) {
        await url_launcher.launchUrl(uri, mode: url_launcher.LaunchMode.externalApplication);
      } else {
        debugPrint('Não foi possível abrir a URL: $url');
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InsuranceWebViewScreen(
            title: title,
            url: url,
          ),
        ),
      );
    }
  }
}
