import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeBanner {
  BannerAd? homeAd;
  late bool adloaded;
  static late int adcount;

  HomeBanner() {
    adloaded = false;
    adcount = 0;
  }

  void createAnchoredBanner() {
    homeAd = BannerAd(
      size: AdSize.banner,
      request: AdRequest(),
      adUnitId: 'ca-app-pub-4923539711755227/6041042746',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          if (adcount < 10) {
            Timer(Duration(seconds: 5), () {
              createAnchoredBanner();
            });
            adcount++;
          }
          // ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    homeAd!.load();
  }
}
