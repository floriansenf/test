import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/components/rounded_button.dart';
import 'package:login/components/rounded_input_field.dart';
import 'package:login/components/rounded_password_field.dart';
import 'package:login/constants.dart';
import 'package:login/screens/forgotpassword/forgotpassword_screen.dart';
import 'package:login/screens/login/LoginController.dart';
import 'package:login/screens/login/components/background.dart';
import 'package:login/screens/login/components/login_container.dart';
import 'package:login/screens/signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  static Future<bool> connection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: LoginContainer(),
        ),
      ),
    );
  }
}

class LoginContainer extends StatefulWidget {
  LoginController loginController = Get.put(LoginController());

  LoginContainer({Key key}) : super(key: key);

  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.03),
          Image.asset("assets/images/login.png", height: size.height * 0.35),
          SizedBox(height: size.height * 0.03),
          Obx(() {
            if (widget.loginController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return LoginContainer2(
                  response: widget.loginController.return_value.value,
                  controller1: controller1,
                  controller2: controller2,
                  loginController: widget.loginController);
            }
          }),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Du hast dein Passwort vergessen?",
                style: TextStyle(color: kPrimaryColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ForgotPasswordScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  " Zurücksetzen",
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  "Registrieren",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
