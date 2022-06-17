// To parse this JSON data, do
//
//     final temparature = temparatureFromJson(jsonString);

import 'dart:convert';

Temparature temparatureFromJson(String str) => Temparature.fromJson(json.decode(str));

String temparatureToJson(Temparature data) => json.encode(data.toJson());

class Temparature {
    Temparature({
        required this.temp,
        required this.id,
        required this.ownerId,
        required this.dateCreated,
        required this.dateLastUpdated,
    });

    double temp;
    int id;
    int ownerId;
    DateTime dateCreated;
    DateTime dateLastUpdated;

    factory Temparature.fromJson(Map<String, dynamic> json) => Temparature(
        temp: json["temp"] as double,
        id: json["id"],
        ownerId: json["owner_id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateLastUpdated: DateTime.parse(json["date_last_updated"]),
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "id": id,
        "owner_id": ownerId,
        "date_created": dateCreated.toIso8601String(),
        "date_last_updated": dateLastUpdated.toIso8601String(),
    };
}
