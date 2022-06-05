import 'dart:collection';
import 'dart:convert';

import 'package:air_quality_application/models/Data.dart';
import 'package:air_quality_application/models/Predict.dart';
import 'package:air_quality_application/models/Recommend.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Data1 {
    final String API;
    final String Description;
    final String Auth;
    final bool HTTPS;
    final String Cors;
    final String Link;
    final String Category; 
  const Data1({
    required this.API,
    required this.Description,
    required this.Auth,
    required this.HTTPS,
    required this.Cors,
    required this.Link,
    required this.Category,
  });
  factory Data1.fromJson(Map<String, dynamic> json) {
    return Data1(
      API: json['API'],
      Description: json['Description'],
      Auth: json['Auth'],
      HTTPS: json['HTTPS'],
      Cors: json['Cors'],
      Link: json['Link'],
      Category: json['Category'],
    );
  }
}
class HttpService {
  final database = FirebaseDatabase(
          databaseURL:
              'https://game-of-life-5ec31-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .reference();


  Stream<Event> fetchRecommend() {
    // final response = await http.get(Uri.https(
    //     'microcontrollers-assign.herokuapp.com', 'api/data/recommend'));
    // if (response.statusCode == 200) {
    //   return Recommend.fromJson(jsonDecode(response.body));
    // } else {
    //   return Recommend();
    // }
    final recommendRef = database.child('recommend');
    return recommendRef.onValue;
  }

 

  Future<Data1> fetchData() async{
    final response = await http.get(
        Uri.parse('https://api.publicapis.org/entries'));
    if (response.statusCode == 200) {
      return Data1.fromJson(jsonDecode(response.body[0]));
    } else {
      return Data1(API: 'API', Description: 'Description', Auth: 'Auth', HTTPS: false, Cors: 'Cors', Link: 'Link', Category: 'Category');
    }
    // final dataRef = database.child('data');
    // return dataRef.orderByKey().limitToLast(1).onValue;
    //http.post(url)
  }

  Stream<Event> fetchPredict() {
  final predictRef = database.child('prediction');
  return predictRef.onValue;
  }

  Stream<Event> fetchListData() {
    // final response = await http
    //     .get(Uri.https('microcontrollers-assign.herokuapp.com', 'api/data'));
    // List<Data> list = [];
    // if (response.statusCode == 200) {
    //   Iterable l = json.decode(response.body);
    //   list = List<Data>.from(l.map((e) => Data.fromJson(e)));
    // }
    // return list;
    final dataRef = database.child('data');
    return dataRef.orderByKey().onValue;
  }
  //ham verified username and password
  Future<bool> login(String username, String password) async {
    return true;
    //khi nao Trung Anh gui BackEnd thi sua lai link o day, luu y su dung mang Lan va bo return true o tren (YwY)
    final response = await http.get(Uri.http('192.168.1.38:8080', 'DAVDK_war_exploded/api/login/$username/$password'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }//else response.statusCode == 404
    return false;
  }
}
