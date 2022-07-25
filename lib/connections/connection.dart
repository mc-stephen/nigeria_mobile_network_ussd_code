import 'dart:io';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:nigeria_mobile_network_ussd_code/components/component.dart';

//====================================================
/// API LINK
//====================================================
const String api =
    "https://raw.githubusercontent.com/Axxellance/nigeria_mobile_network_ussd_code_json_data/main/network_ussd_code.json";

//====================================================
/// GET DATA FROM PROVIDED API LINK
//====================================================
class GetDataFromApi {
  //====================================================
  /// CHECK FOR INTERNET CONNECTION ON MOBILE APP
  //====================================================
  Future<bool> checkInternetconection() async {
    try {
      await InternetAddress.lookup('example.com');
    } catch (_) {
      showSnackBar(
          "No internet connection can be detected!, Please put on your internet or try connecting to a free wifi");
      return false;
    }
    return true;
  }

  //====================================================
  /// THE GET DATA REQUEST
  //====================================================
  Future<bool> get() async {
    http.Response url;
    bool networkStatus = await checkInternetconection();
    if (!networkStatus) return false;

    try {
      url = await http.get(Uri.parse(api));
    } catch (e) {
      showSnackBar(
          "Oops! something went wrong and we couln't get the required data.");
      return false;
    }
    return await addDataToLocalDB(url.body);
  }

  //====================================================
  /// STORE DATA TO LOCAL DB AFTER A SUCCEFFUL REQUEST
  //====================================================
  Future<bool> addDataToLocalDB(String data) async {
    Box box = Hive.box('onlineData');
    if (data.isEmpty) {
      showSnackBar(
          "Oops! an empty data was received from the server, please contact us for help");
      return false;
    }
    await box.clear();
    Map jsonData = jsonDecode(data);
    await box.putAll(jsonData);
    return true;
  }
}
