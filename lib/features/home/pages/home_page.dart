// import 'dart:async';

import 'package:cat_and_dog/features/bloc/app_color_bloc.dart';
import 'package:cat_and_dog/features/bloc/storage_bloc.dart';
import 'package:cat_and_dog/features/cats/page/cat_page.dart';
import 'package:cat_and_dog/features/dogs/dogs.dart';
import 'package:cat_and_dog/features/home/pages/translate_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  static const List<Widget> _widgetOptions = <Widget>[TranslateHomePage(), CatPage(), DogPage()];
  int _selectedIndex = 0;
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (context.read<StorageBLoc>().state.isIntro == null) {
      context.read<StorageBLoc>().add(StorageSet());
    }

    _tabController = TabController(length: 2, vsync: this);
    MobileAds.instance.initialize();
    final isIntro = context.read<StorageBLoc>().state.isIntro;
    //TODO: open ads
    // if (isIntro != null) {
    //   _loadInterstitialAd();
    //   Timer(const Duration(seconds: 5), () {
    //     if (_isInterstitialAdReady) {
    //       _interstitialAd.show();
    //     }
    //   });
    // }
    super.initState();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Use your Ad Unit ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<AppColorBLoc, AppColorState>(builder: (context, state) {
        return Scaffold(
          // backgroundColor: screenCatColor,
          backgroundColor: state.color,
          appBar: AppBar(
            toolbarHeight: 0,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: state.color),
            elevation: 0.0,
            backgroundColor: state.color,
            automaticallyImplyLeading: false,
          ),
          body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/translate.svg"),
                    activeIcon: SvgPicture.asset('assets/svg/translate_active.svg'),
                    label: 'Translate',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/cat.svg"),
                    activeIcon: SvgPicture.asset('assets/svg/cat_active.svg'),
                    label: 'Cat',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/dog.svg"),
                    activeIcon: SvgPicture.asset('assets/svg/dog_active.svg'),
                    label: 'Dog',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                onTap: _onItemTapped,
              ),
            ),
          ),
        );
      }),
    );
  }
}
