import 'package:cat_and_dog/features/ads/ads_hepper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static final AdManager _instance = AdManager._internal();
  factory AdManager() {
    return _instance;
  }

  AdManager._internal();

  BannerAd? _bannerAd;

  void initialize() {
    MobileAds.instance.initialize();
  }

  void createBannerAd() {
    _bannerAd ??= BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('Banner loaded.');
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            print('Banner failed to load: $error');
          },
        ),
      )..load();
  }

  void disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  Widget getBannerAdWidget() {
    if (_bannerAd == null) {
      createBannerAd();
    }
    return _bannerAd != null
        ? Container(
            alignment: Alignment.center,
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          )
        : SizedBox.shrink();
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdManager().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ad Example'),
        ),
        body: Center(
          child: AdManager().getBannerAdWidget(),
        ),
      ),
    );
  }
}
