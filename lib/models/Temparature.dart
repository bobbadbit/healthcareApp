// To parse this JSON data, do
//
//     final temparature = temparatureFromJson(jsonString);

import 'dart:convert';

List<Temparature> temparatureFromJson(String str) => List<Temparature>.from(json.decode(str).map((x) => Temparature.fromJson(x)));

String temparatureToJson(List<Temparature> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Temparature {
    Temparature({
        required this.temp,
    });

    int temp;

    factory Temparature.fromJson(Map<String, dynamic> json) => Temparature(
        temp: json["temp"],
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
    };
}
