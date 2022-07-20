import 'dart:convert';

import 'package:dummy1/helpers/Api.dart';
import 'package:dummy1/models/PostaddResponeModel.dart';
import 'package:dummy1/models/PostingResponeModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class News {
  static Future<PostingResponseModel> getposting() async {
    String errors = "".obs();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _token = prefs.getString('token');
    var response = await client.get(
      Uri.parse('$Base_url/main/getall'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': _token.toString(),
      },
    );

    if (response.statusCode == 200) {
      var json = response.body;
      var postingRes = PostingResponseModel.fromJson(
          jsonDecode(json) as Map<String, dynamic>);
      print(postingRes);
      if (postingRes != null) {
        return postingRes;
      } else {
        return postingRes;
      }
    } else {
      return PostingResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
  }

  static Future<PostaddResponseModel> posting(
      {String? caption,
      String? display_picture,
      String? display_content}) async {
    String errors = "".obs();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _token = prefs.getString('token');
    var response = await client.post(Uri.parse('$Base_url/main/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': _token.toString(),
        },
        body: jsonEncode(<String, String>{
          "caption": caption!,
          "display_picture": display_picture!,
          "display_content": display_content!
        }));

    if (response.statusCode == 201) {
      var json = response.body;
      var postingRes = PostaddResponseModel.fromJson(
          jsonDecode(json) as Map<String, dynamic>);
      print(postingRes.result);
      if (postingRes != null) {
        return postingRes;
      } else {
        errors = "gagal".obs();
        return postingRes;
      }
    } else {
      return PostaddResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
  }
}
