import 'package:cat_and_dog/features/bloc/app_color_bloc.dart';
import 'package:cat_and_dog/features/home/pages/widgets/cat_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../purchase/purchase.dart';
import 'widgets/dog_home_widget.dart';

class TranslateHomePage extends StatefulWidget {
  final bool isCatPage;
  const TranslateHomePage({super.key, this.isCatPage = true});

  @override
  _TranslateHomePageState createState() => _TranslateHomePageState();
}

class _TranslateHomePageState extends State<TranslateHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // hotfix: TODO: can check lai logic
    context.read<AppColorBLoc>().add(AppColorFetch(color: const Color(0xFFFF949B)));
    if (!widget.isCatPage) {
      context.read<AppColorBLoc>().add(AppColorFetch(color: const Color(0xFFFDEB94)));
      _tabController.index = 1;
    }
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        context.read<AppColorBLoc>().add(AppColorFetch(color: const Color(0xFFFF949B)));
      } else {
        context.read<AppColorBLoc>().add(AppColorFetch(color: const Color(0xFFFDEB94)));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void gotoPurchase() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PurchasePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 8),
      child: BlocBuilder<AppColorBLoc, AppColorState>(builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(onTap: gotoPurchase, child: SvgPicture.asset('assets/svg/purchase.svg', width: 21, height: 20)),
            ),
            const Gap(20),
            Container(
              height: 45,
              decoration: BoxDecoration(color: state.color, borderRadius: BorderRadius.circular(25.0)),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                padding: const EdgeInsets.only(left: 20, right: 20),
                dividerHeight: 0.0,
                tabs: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 7.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3.0), borderRadius: BorderRadius.circular(20.0)),
                    child: const Tab(text: 'Cat'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 7.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3.0), borderRadius: BorderRadius.circular(20.0)),
                    child: const Tab(text: 'Dog'),
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(child: TabBarView(controller: _tabController, children: const [CatHomeWidget(), DogHomeWidget()])),
            // Center(child: AdManager().getBannerAdWidget()),
          ],
        );
      }),
    );
  }
}
