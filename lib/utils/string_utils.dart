import 'dart:convert';

import 'package:intl/intl.dart';

String parseDate(int timeFromEpoch) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeFromEpoch);
  var dateFormat = DateFormat('HH:mm:ss dd/MM/yyyy');
  String time = dateFormat.format(dateTime);
  return time;
  // return '${dateTime.hour}:${dateTime.minute}:${dateTime.second} ${dateTime.day}/${dateTime.month}/${dateTime.year}';
}

Map<String, dynamic> parseDynamicToMap(dynamic data) {
  return json.decode(json.encode(data)) as Map<String, dynamic>;
}