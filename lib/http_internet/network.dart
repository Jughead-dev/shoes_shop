import 'dart:convert';

import 'package:http/http.dart';

import 'post.dart';

class Network {
  static String BASE_URL = "jsonplaceholder.typicode.com";
  static Map<String, String> headers = {'Content-type': 'application/json; charset=UTF-8'};

  /* Http apis */
  static const String POST_LIST = "/posts";
  static const String POST_CREATE = "/posts";
  static const String POST_UPDATE = "/posts/"; //{id}
  static const String POST_DELETE = "/posts/"; //{id}

  /* Http requests*/
  static Future<String?> GET(String api, Map<String, String> params) async {
    final uri = Uri.https(BASE_URL, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }

    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    final uri = Uri.https(BASE_URL, api, params);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode >= 200 || response.statusCode <= 299) {
      return response.body;
    }

    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    final uri = Uri.https(BASE_URL, api, params);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode >= 200 || response.statusCode <= 299) {
      return response.body;
    }

    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async {
    final uri = Uri.https(BASE_URL, api, params);
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

  static Map<String, String> paramsCreate(Post post) {
    Map<String, String> params = {};
    params.addAll({"title": post.title, "body": post.body, "userId": post.userId.toString()});
    return params;
  }

  static Map<String, String> paramsUpdate(Post post) {
    Map<String, String> params = {};
    params.addAll({
      "id": post.id.toString(),
      "title": post.title,
      "body": post.body,
      "userId": post.userId.toString(),
    });
    return params;
  }

  /*parsing*/

  static List<Post> parsePostList(String response) {
    final json = jsonDecode(response);
    final data = List<Post>.from(json.map((element) => Post.fromJson(element)));
    return data;
  }

  static Post parsePost(String res) {
    final json = jsonDecode(res);
    final data = Post.fromJson(json);
    return data;
  }
}
