import 'package:http/http.dart';

class UnsplashApi {
  static String BASE = "api.unsplash.com";
  static Map<String, String> headers = {
    "Content-type": "application/json; charset=UTF-8",
    "Authorization":"Client-ID RhMTjuEdg-p98bScS8ySYKaVhXA_hABjtNqAvpYze9w",
  };

  /* Http apis */
  static const String IMAGE_LIST = "/photos";

  /* Http requests */
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    final uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
}