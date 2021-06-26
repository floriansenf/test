import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login/components/rounded_button.dart';
import 'package:login/components/rounded_input_field.dart';
import 'package:login/components/rounded_password_field.dart';
import 'package:login/screens/home/screen_home.dart';
import 'package:login/screens/login/LoginController.dart';
import 'package:login/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginContainer2 extends StatelessWidget {
  final String response;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final LoginController loginController;
  const LoginContainer2(
      {Key key,
        @required  this.response,
        @required  this.controller1,
        @required  this.controller2,
        @required this.loginController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message="";
    switch(response){
      case "start":
        message="" ;
        break;
      case "missing-mail":
        message="Diese Email ist nicht vergeben" ;
        break;
      case "password":
        message="Überprüfe dein Passwort";
        break;
      case "error":
        message="Es ist ein Fehler aufgetreten";
        break;
      case "success":
        SchedulerBinding.instance.addPostFrameCallback(
                (_) {
              Future<SharedPreferences> sharedpreferences =
              SharedPreferences.getInstance();
              sharedpreferences.then((value) => {

                value.setBool("isloggedin", true),
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => HomeScreen()),
                ),
              });
            });
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          RoundedInputField(
            hintText: "E-Mail",
            onChanged: (value) {},
            controller: controller1,
          ),
          RoundedPasswordField(
            controller: controller2,
          ),
          RoundedButton(
            text: "Login",
            press: () {
              LoginScreen.connection().then((value) {
                if (value) {

                  String email = controller1.text;
                  String password = controller2.text;
                  loginController.postrequest(email, password); // _futureresponse =

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                    Text("Es konnte keine Verbindung hergestellt werden"),
                  ));
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
