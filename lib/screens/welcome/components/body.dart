import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/components/rounded_button.dart';
import 'package:login/constants.dart';
import 'package:login/screens/home/screen_home.dart';
import 'package:login/screens/signup/signup_screen.dart';
import 'package:login/screens/welcome/components/background.dart';
import 'package:login/screens/login/login_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Wilkommen in der Vertriebsapp",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Login Vertrieb",
              color: kPrimaryColor,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                },));
              },
            ),
            RoundedButton(
              text: "Login Administration",
              color: kPrimaryLightColor,
              textcolor: Colors.black,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                },));
              },
            ),
          ],
        ),
      ),

    );
  }
}



