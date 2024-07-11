import 'package:cat_and_dog/features/ads/manager/ads_banner_manager.dart';
import 'package:cat_and_dog/features/bloc/app_color_bloc.dart';
import 'package:cat_and_dog/features/home/pages/widgets/cat_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/dog_home_widget.dart';

class TranslateHomePage extends StatefulWidget {
  const TranslateHomePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: BlocBuilder<AppColorBLoc, AppColorState>(builder: (context, state) {
        return Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: state.color,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                padding: const EdgeInsets.only(left: 20, right: 20),
                dividerHeight: 0.0,
                tabs: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(20.0)),
                    child: const Tab(text: 'Cat'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(20.0)),
                    child: const Tab(text: 'Dog'),
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [CatHomeWidget(), DogHomeWidget()],
              ),
            ),
            Center(child: AdManager().getBannerAdWidget()),
          ],
        );
      }),
    );
  }
}
