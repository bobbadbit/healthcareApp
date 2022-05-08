import 'package:flutter/cupertino.dart';
//lay du lieu gui ra 1 luong rieng
//noi khac se lay du lieu tu luong nay`
class DataViewModel extends ChangeNotifier {
  double temp = 40.0;
  ValueNotifier<double> tempNotifier = ValueNotifier(40.00);
  onChanged(double value) {  
    print('onChanged: $value');
    tempNotifier.value = value;
  }
}