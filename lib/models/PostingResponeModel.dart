// To parse this JSON data, do
//
//     final postingResponseModel = postingResponseModelFromJson(jsonString);

import 'dart:convert';

PostingResponseModel postingResponseModelFromJson(String str) => PostingResponseModel.fromJson(json.decode(str));

String postingResponseModelToJson(PostingResponseModel data) => json.encode(data.toJson());

class PostingResponseModel {
    PostingResponseModel({
        this.result,
        this.content,
    });

    int? result;
    List<Content>? content;

    factory PostingResponseModel.fromJson(Map<String, dynamic> json) => PostingResponseModel(
        result: json["result"],
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
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
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? displayName;
    String? caption;
    String? displayPicture;
    String? displayContent;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        displayName: json["display_name"],
        caption: json["caption"],
        displayPicture: json["display_picture"],
        displayContent: json["display_content"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "display_name": displayName,
        "caption": caption,
        "display_picture": displayPicture,
        "display_content": displayContent,
        "user_id": userId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
    };
}
