// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    LoginResponseModel({
        this.result,
        this.message,
        this.token,
    });

    int? result;
    String? message;
    String? token;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        result: json["result"],
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "token": token,
    };
}
