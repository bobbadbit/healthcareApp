// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    Users({
        required this.id,
        required this.temp,
        required this.ownerId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    int temp;
    String ownerId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["_id"],
        temp: json["temp"],
        ownerId: json["owner_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "temp": temp,
        "owner_id": ownerId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
