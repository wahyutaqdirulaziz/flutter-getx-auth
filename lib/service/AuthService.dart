// ignore: file_names
import 'dart:convert';

import 'package:dummy1/helpers/Api.dart';
import 'package:dummy1/models/LoginResponeModel.dart';
import 'package:dummy1/models/RegisterResponeModel.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static Future<LoginResponseModel> login(
      {String? username, String? password}) async {
    String errors = "".obs();
    var response = await client.post(Uri.parse('$Base_url/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            <String, String>{"username": username!, "password": password!}));

    if (response.statusCode == 200) {
      var json = response.body;
      var loginRes =
          LoginResponseModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
      print(loginRes);

      if (loginRes != null) {
        return loginRes;
      } else {
        errors = "username and password is not valid".obs();
        return loginRes;
      }
    } else {
      errors = "Silahkan coba lagi nanti !".obs();
      return LoginResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
  }

  static Future<RegisterResponseModel> regiter(
      {String? firstName,
      String? lastName,
      String? username,
      String? password}) async {
    String errors = "".obs();
    var response = await client.post(Uri.parse('$Base_url/users/register'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "firstName": firstName!,
          "lastName": lastName!,
          "username": username!,
          "password": password!
        }));

    if (response.statusCode == 201) {
      var json = response.body;
      var resiterRes = RegisterResponseModel.fromJson(
          jsonDecode(json) as Map<String, dynamic>);
      print(resiterRes);
      if (resiterRes != null) {
        return resiterRes;
      } else {
        errors = "Register not success".obs();
        return resiterRes;
      }
    } else {
      errors = "Silahkan coba lagi nanti !".obs();
      return RegisterResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
  }
}
