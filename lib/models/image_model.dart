// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

ImageModel imageModelFromJson(String str) =>
    ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  ImageModel({
    this.image,
    this.title,
    this.desc,
    this.bgColor,
    this.textColor,
    this.titleColor,
  });

  final String? image;
  final String? title;
  final String? desc;
  Color? bgColor;
  Color? textColor;
  Color? titleColor;

  ImageModel copyWith({
    String? image,
    String? title,
    String? desc,
    Color? bgColor,
    Color? textColor,
    Color? titleColor,
  }) =>
      ImageModel(
        image: image ?? this.image,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        bgColor: bgColor ?? this.bgColor,
        textColor: textColor ?? this.textColor,
        titleColor: titleColor ?? this.titleColor,
      );

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        image: json["image"],
        title: json["title"],
        desc: json["desc"],
        bgColor: json["bgColor"],
        textColor: json["textColor"],
        titleColor: json["titleColor"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "desc": desc,
        "bgColor": bgColor,
        "textColor": textColor,
        "titleColor": titleColor,
      };
}
