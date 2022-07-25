import 'dart:io';

//======================================================
// SORT OUT THE BANNER ADD WE NEED FOR A SPECIFIC WIDGET
//======================================================
class AdHelper {
  //===================================================
  // BOTTOM BANNAR AD UNIT ID
  //===================================================
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError('Unsupport Platform');
    }
  }

  //===================================================
  // INTERSTITIAL AD UNIT ID
  //===================================================
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8691691433";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError('Unsupport Platform');
    }
  }
}
