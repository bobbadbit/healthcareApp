import 'package:air_quality_application/screens/bluetooth_serial.dart';
import 'package:air_quality_application/service/HttpService.dart';
import 'package:air_quality_application/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:air_quality_application/utils/styleguides/colors.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controller de lay du lieu nhap vao (input username, input password) de so sanh
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

// context: dung` de lay toan bo doi tuong cua app
// async: bat dong bo, sau khi nhap du lieu (username, password) thi doi den khi app ket noi den BackEnd de kiem tra true/ false
  Future<void> login(BuildContext context, String username, String password) async {
    //(*) vi da duoc bao o ham main nen co the tuy y su dung cac doi tuong cua httpService
    final service = Provider.of<HttpService>(context, listen: false);
    //await : ham` giong nhu mo ta o async
    //goi ham login tu Httpservice
    final result = await service.login(username, password);
    if (result) {
      moveToHome(context);
    }
    else showToast(context, 'Login failed');
  }

  void moveToHome(BuildContext context) {
            Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BluetoothApp()),
  );
  }
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/teriteri.png'),
      ),
    );

    final email = TextFormField(
      //controller: lay text da nhap gui vao bien usernameController
      controller: usernameController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Enter your email...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      //controller: lay text da nhap gui vao bien passController
      controller: passwordController,
      autofocus: false,
      //dau ***
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    // final loginButton = new RaisedButton(
    //   textColor: Colors.white,
    //   color: whiteColor,
    //   child: Container(
    //           alignment: Alignment.center,
    //           width: double.infinity,
    //           height: 50,
    //           decoration: BoxDecoration(               
    //             gradient: LinearGradient(
    //                 colors: [darkBlueGradientColor, lightBlueGradientColor])
    //             ),
    //             child: const Text('Sign In'),
    //           ),
    //   //splashColor: Colors.blueGrey,
              
    //   onPressed: () {
    //     String username = usernameController.text;
    //     String word = passwordController.text;
    //     login(context, username, word);
    //     // Perform some action
    //   },
    // );
  final loginButton = ButtonTheme(
  buttonColor: whiteColor,
  //minWidth: 700.0,
  //height: 50.0,
  child: RaisedButton(
    textColor: Colors.white,
    child: Container(
      
      alignment: Alignment.center,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
                gradient: LinearGradient(
                   colors: [darkBlueGradientColor, lightBlueGradientColor])
                  ,
                ),          
    child: Text("Sign In")
  ),
  onPressed: () {
      String username = usernameController.text;
      String word = passwordController.text;
      login(context, username, word);
    },
  ),
);
    // final forgotLabel = FlatButton(
    //   child: Text(
    //     'Forgot password?',
    //     style: TextStyle(color: Colors.black54),
    //   ),
    //   onPressed: () {},
    // );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 45.0),
            email,
            SizedBox(height: 10.0),
            password,
            SizedBox(height: 30.0),
            loginButton,
            //forgotLabel
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}