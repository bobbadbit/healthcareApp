// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    Users({
        required this.email,
        required this.id,
        required this.isActive,
        required this.patients,
    });

    String email;
    int id;
    bool isActive;
    List<dynamic> patients;

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        email: json["email"],
        id: json["id"],
        isActive: json["is_active"],
        patients: List<dynamic>.from(json["patients"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "is_active": isActive,
        "patients": List<dynamic>.from(patients.map((x) => x)),
    };
}
