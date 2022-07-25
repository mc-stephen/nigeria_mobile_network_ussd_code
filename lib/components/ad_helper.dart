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
      return "";
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
      return "";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError('Unsupport Platform');
    }
  }
}
