import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/bloc/home_bloc.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/bloc/home_event.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/bloc/home_state.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/contracts_card_widget.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/custom_app_bar.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/custom_drawer_widget.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/family_card_widget.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/insurance_grid_widget.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/welcome_banner_widget.dart';
import 'package:tokyo_marine_insurance/core/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = Modular.get<HomeBloc>();

  @override
  void initState() {
    super.initState();
    _homeBloc.add(LoadUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = EdgeInsets.symmetric(
      horizontal: kIsWeb ? context.wp(1) : context.wp(4),
    );

    return BlocProvider.value(
      value: _homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeInitialState) {
            Modular.to.navigate('/');
          }
        },
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          drawer: const CustomDrawer(),
          appBar: const CustomAppBar(),
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeBannerWidget(),
                  SizedBox(height: kIsWeb ? context.hp(2) : context.hp(1.5)),
                  Padding(
                    padding: horizontalPadding,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _buildSectionTitle('Cotar e Contratar'),
                    ),
                  ),
                  SizedBox(height: context.hp(1)),
                  const InsuranceGridWidget(),
                  SizedBox(height: kIsWeb ? context.hp(2) : context.hp(1.5)),
                  Padding(
                    padding: horizontalPadding,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: kIsWeb ? double.infinity : double.infinity,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Minha Família'),
                          SizedBox(height: context.hp(1)),
                          const FamilyCardWidget(),
                          SizedBox(height: kIsWeb ? context.hp(4) : context.hp(3)),
                          _buildSectionTitle('Contratados'),
                          SizedBox(height: context.hp(1)),
                          const ContractsCardWidget(),
                          SizedBox(height: context.hp(2)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}