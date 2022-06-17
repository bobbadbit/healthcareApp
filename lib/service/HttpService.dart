import 'dart:convert';

import 'package:air_quality_application/models/Data.dart';
import 'package:air_quality_application/models/Predict.dart';
import 'package:air_quality_application/models/Recommend.dart';
import 'package:air_quality_application/models/Temparature.dart';
import 'package:air_quality_application/models/UserLogin.dart';
import 'package:air_quality_application/models/Users.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
// DataModel dataModelFromJson ()

class HttpService {
  final database = FirebaseDatabase(
          databaseURL:
              'https://game-of-life-5ec31-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .reference();

  var id;

  var ownerId;

  var dateLastUpdated;

  var dateCreated;


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

  Stream<Event> fetchData() {
    // final response = await http.get(
    //     Uri.https('microcontrollers-assign.herokuapp.com', 'api/data/latest'));
    // if (response.statusCode == 200) {
    //   return Data.fromJson(jsonDecode(response.body));
    // } else {
    //   return Data();
    // }
    final dataRef = database.child('data');
    return dataRef.orderByKey().limitToLast(1).onValue;
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
Future<UserLogin> login(String username, String password) async {
    //return true;
    //final response = await http.get(Uri.http('192.168.1.38:8080', 'DAVDK_war_exploded/api/login/$username/$password'));
    final response = await http.post(Uri.http('healthcaresystemu.herokuapp.com','api/login'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(<String, String>
      {
        "username" : username,
        "password" : password
      }
    ));

    print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 200) {
          //final String responseString = response.body;
    return UserLogin.fromJson(jsonDecode(response.body));
    }//else response.statusCode == 404
    return throw Exception('Failed to Login');
  }
  
  Future<Temparature> sendData(int patient_id,double temp) async{
      final response = await http.post(Uri.parse("http://192.168.2.49:8000/Patient/${patient_id}/${temp}"),
        body: {
            "temp": temp.toString()
        }
    );
    // final String apiURL ="http://192.168.2.49:8000/Patient/${patient_id}/${temp}";
    // final response = await http.post(apiURL, body: {
    //   "temp": temp
    // });
  if(response.statusCode == 200){
    final String responseString = response.body;
    return temparatureFromJson(response.body);
  }else{
    // return Temparature(temp: temp, id: id, ownerId: ownerId, dateCreated: dateCreated, dateLastUpdated: dateLastUpdated);
    throw Exception("Fail");
  }
  }
  Future<Users> getData() async{
    final response = await http.get(Uri.https('172.15.74.141:8000','users/1'));
    if(response.statusCode == 200){
      return Users.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Fail to load User");
    }
  }
}
