import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager {
  int _numInterstitialLoadAttempts = 0;
  final int maxFailedLoadAttempts = 3;
  int _numRewardedLoadAttempts = 0;
  InterstitialAd? _interstitialAd;
  late AdWidget bannerAdWidget;
  RewardedAd? _rewardedAd;
  late BannerAd adBanner;

  void createBannerAd() {
    adBanner = BannerAd(
      adUnitId:
          BannerAd.testAdUnitId, //'ca-app-pub-2837828701670824/2577493115',
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

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId:
          RewardedAd.testAdUnitId, //ca-app-pub-2837828701670824/3886705356
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          debugPrint('$ad loaded.');
          _numRewardedLoadAttempts = 0;
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
            createRewardedAd();
          }
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      debugPrint('Warning: attempt to show rewarded before loaded.');
      keepTryingShowRewardedAd();
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      debugPrint(
          '$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
  }

  void keepTryingShowRewardedAd() {
    Future.delayed(const Duration(seconds: 2), () {
      _showRewardedAd();
    });
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId:
          InterstitialAd.testAdUnitId, //ca-app-pub-2837828701670824/7333505080
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void keepTryingShowInterstitialAd() {
    Future.delayed(const Duration(seconds: 2), () {
      _showInterstitialAd();
    });
  }

  void dispose() {
    adBanner.dispose();
  }
}
