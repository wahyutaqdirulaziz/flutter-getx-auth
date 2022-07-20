// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
    RegisterResponseModel({
        this.user,
    });

    User? user;

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
    };
}

class User {
    User({
        this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.createdAt,
    });

    int? id;
    String? firstName;
    String? lastName;
    String? username;
    DateTime? createdAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "createdAt": createdAt!.toIso8601String(),
    };
}
