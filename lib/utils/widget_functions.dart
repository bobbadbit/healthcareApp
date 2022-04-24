import 'package:flutter/material.dart';
Widget addHorizontalSpace(double width) {
  return SizedBox(width: width,);
}

Widget addVerticalSpace(double height) {
  return SizedBox(height: height,);
}

void showToast(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text('$message'),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showProgressBar(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}
