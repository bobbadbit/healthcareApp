import 'dart:io';
import 'dart:ui';

import 'package:air_quality_application/components/my_bottom_navigation.dart';
import 'package:air_quality_application/screens/bluetooth.dart';
import 'package:air_quality_application/screens/bluetooth_serial.dart';
import 'package:air_quality_application/screens/login.dart';
import 'package:air_quality_application/service/HttpService.dart';
import 'package:air_quality_application/service/blue_tooth_service.dart';
import 'package:air_quality_application/utils/styleguides/colors.dart';
import 'package:air_quality_application/utils/styleguides/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/gen/flutterblue.pb.dart';
import 'package:provider/provider.dart';
import 'package:air_quality_application/screens/login.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  await Firebase.initializeApp();
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return MultiProvider(
      //wrap httpService vao` context de su dung o login.dart (*)
      providers: [
        Provider<HttpService>(
          create: (context) => HttpService(),
        ),
        Provider<BackgroundCollectingTask>(create:(context) => BackgroundCollectingTask(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: darkBlueGradientColor,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
          fontFamily: 'Montserrat'
        ),
        home: 
        BluetoothApp() 
        //MyBottomNavigationBar()
        // LoginPage()
        , 
      ),
    );
  }
}
//12h19p