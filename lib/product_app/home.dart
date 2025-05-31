import 'dart:convert';

import 'package:http/http.dart';
import 'package:translate/product_app/product.dart';

class Home {
  static String BASE = "4d4b3e0dd355ce67.mokky.dev";
  static Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8',
  };
  /* Http apis */
  static const String PRODUCT_LIST = "/products";
  static const String PRODUCT_CREATE = "/products";
  static const String POST_DELETE = "/products/"; //{id}
  /* Http requests*/
  static Future<String?> GET(String api, Map<String, String> params) async {
    final uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }

    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    final uri = Uri.https(BASE, api, params);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode >= 200 || response.statusCode <= 299) {
      return response.body;
    }

    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    final uri = Uri.https(BASE, api, params);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode >= 200 || response.statusCode <= 299) {
      return response.body;
    }

    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async {
    final uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode >= 200 || response.statusCode <= 299) {
      return response.body;
    }

    return null;
  }

  /* params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Product product) {
    Map<String, String> params = {};
    params.addAll({
      "name": product.name,
      "price": product.price,
      "description": product.description,
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Product product) {
    Map<String, String> params = {};
    params.addAll({
      "id": product.id.toString(),
      "name": product.name,
      "price": product.price.toString(),
      "description": product.description,
    });
    return params;
  }

  /*parsing*/

  static List<Product> parsePostList(String response) {
    final json = jsonDecode(response);
    final data = List<Product>.from(
      json.map((element) => Product.fromJson(element)),
    );
    return data;
  }

  static Product parsePost(String res) {
    final json = jsonDecode(res);
    final data = Product.fromJson(json);
    return data;
  }
}
