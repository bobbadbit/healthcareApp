// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

List<UserLogin> userLoginFromJson(String str) => List<UserLogin>.from(json.decode(str).map((x) => UserLogin.fromJson(x)));

String userLoginToJson(List<UserLogin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserLogin {
    UserLogin({
        required this.username,
        required this.password,
    });

    String username;
    String password;

    factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}