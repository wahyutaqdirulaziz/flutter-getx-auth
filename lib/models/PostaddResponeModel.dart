// To parse this JSON data, do
//
//     final postaddResponseModel = postaddResponseModelFromJson(jsonString);

import 'dart:convert';

PostaddResponseModel postaddResponseModelFromJson(String str) => PostaddResponseModel.fromJson(json.decode(str));

String postaddResponseModelToJson(PostaddResponseModel data) => json.encode(data.toJson());

class PostaddResponseModel {
    PostaddResponseModel({
        this.result,
        this.content,
    });

    int? result;
    Content? content;

    factory PostaddResponseModel.fromJson(Map<String, dynamic> json) => PostaddResponseModel(
        result: json["result"],
        content: Content.fromJson(json["content"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "content": content!.toJson(),
    };
}

class Content {
    Content({
        this.id,
        this.displayName,
        this.caption,
        this.displayPicture,
        this.displayContent,
        this.userId,
        this.updatedAt,
        this.createdAt,
    });

    int? id;
    String? displayName;
    String? caption;
    String? displayPicture;
    String? displayContent;
    int? userId;
    DateTime? updatedAt;
    DateTime? createdAt;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        displayName: json["display_name"],
        caption: json["caption"],
        displayPicture: json["display_picture"],
        displayContent: json["display_content"],
        userId: json["user_id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "display_name": displayName,
        "caption": caption,
        "display_picture": displayPicture,
        "display_content": displayContent,
        "user_id": userId,
        "updatedAt": updatedAt!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
    };
}
