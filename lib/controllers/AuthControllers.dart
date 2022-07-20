import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dummy1/models/LoginResponeModel.dart';
import 'package:dummy1/service/AuthService.dart';
import 'package:dummy1/views/auth/LoginPage.dart';
import 'package:dummy1/views/auth/RegisterPage.dart';
import 'package:dummy1/views/home/HomePage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  List<dynamic> user = <LoginResponseModel>[].obs();
  var loginProcess = false.obs;
  var registerProcess = false.obs;
  var error = "".obs();
  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    _setInitialScreen();
  }

  _setInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => LoginPage());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => HomePage());
    }
  }

  Future<String> login({String? username, String? password}) async {
    try {
      loginProcess(true);
      var loginResp = await Auth.login(username: username, password: password);
      if (loginResp.result == 1) {
        //success
        final prefs = await SharedPreferences.getInstance();
        var bytes = utf8.encode(password.toString());
        var digest1 = sha256.convert(bytes);
        print(digest1);
         prefs.setString("username", username.toString());
        prefs.setString("password", digest1.toString());
        user.assign(loginResp);
        
        print("token :" + loginResp.token.toString());
       
        prefs.setString("token", loginResp.token.toString());
      } else {
        error = "Username and password is not valid !";
      }
    } finally {
      loginProcess(false);
    }
    return error;
  }

  Future<String> register(
      {String? firstName,
      String? lastName,
      String? username,
      String? password}) async {
    error = "";
    try {
      registerProcess(true);
      var registerResp = await Auth.regiter(
          firstName: firstName,
          lastName: lastName,
          username: username,
          password: password);
      if (registerResp.user != "") {
        //success
        Get.offAll(() => LoginPage());
      } else {
        error = "Username and password is not valid !";
        Get.offAll(() => RegisterPage());
      }
    } finally {
      registerProcess(false);
    }
    return error;
  }
}
