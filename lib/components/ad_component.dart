import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nigeria_mobile_network_ussd_code/components/ad_helper.dart';

//===========================================
// BOTTOM BANNER AD FUNCTION
//===========================================
class GlobalBottomBannerAd {
  late BannerAd bottomBannerAd;
  bool isBottomBannerAdLoaded = false;

  createBottomBannerAd({required Function setState}) {
    bottomBannerAd = BannerAd(
      size: AdSize.banner,
      request: const AdRequest(),
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBottomBannerAdLoaded = true;
          setState();
        },
        onAdFailedToLoad: (ad, error) => bottomBannerAd.dispose(),
      ),
    );
    bottomBannerAd.load();
  }
}

//===========================================
// INDEX PAGE INTERSTITIAL AD FUNCTION
//===========================================
class IndexPageInterstitialAd {
  //===========================================
  // VERIABLE RELETED TO ALL ADS FUNCTION
  //===========================================
  int interstitialLoadAttempts = 0;
  InterstitialAd? pageTransistionAd;
  final int maxAdFailedLoadAttempts = 3;

  //===========================================
  // CREATE INTERSTITIAL AD UNIT
  //===========================================
  void createPageTransistionAd() {
    InterstitialAd.load(
      request: const AdRequest(),
      adUnitId: AdHelper.interstitialAdUnitId,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          pageTransistionAd = ad;
          interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          pageTransistionAd = null;
          interstitialLoadAttempts++;
          if (interstitialLoadAttempts >= maxAdFailedLoadAttempts) {
            createPageTransistionAd();
          }
        },
      ),
    );
  }

  //===========================================
  // LOAD THE INTERSTITIAL AD WIDGET
  //===========================================
  void showPageTransistionAd() {
    if (pageTransistionAd != null) {
      pageTransistionAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          pageTransistionAd = null;
          createPageTransistionAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          pageTransistionAd = null;
          createPageTransistionAd();
        },
      );
      pageTransistionAd!.show();
    }
  }
}
