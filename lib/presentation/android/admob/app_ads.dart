import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager {
  late BannerAd adBanner;

  void createBannerAd() {
    adBanner = BannerAd(
      adUnitId: 'ca-app-pub-2837828701670824/2577493115',
      listener: const BannerAdListener(),
      request: const AdRequest(),
      size: AdSize.banner,
    );
  }

  Container adBannerWidget() {
    adBanner.load();
    return Container(
      height: adBanner.size.height.toDouble(),
      width: adBanner.size.width.toDouble(),
      alignment: Alignment.center,
      child: AdWidget(ad: adBanner),
    );
  }

  void dispose() {
    adBanner.dispose();
  }
}
