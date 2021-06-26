import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/components/already_have_an_account.dart';
import 'package:login/components/rounded_button.dart';
import 'package:login/components/rounded_input_field.dart';
import 'package:login/components/rounded_password_field.dart';
import 'package:login/screens/login/components/background.dart';
import 'package:login/screens/signup/signup_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Login Vertrieb", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: size.height * 0.03),
          Image.asset("assets/images/login.png",
              height: size.height * 0.35),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: "E-Mail",
            onChanged: (value) {},
          ),
          RoundedPasswordField(


          ),

          RoundedButton(
            text: "LOGIN",
            press: () {},
          ),
          SizedBox(height: size.height * 0.03),
          Text("Du hast dein Passwort vergessen? Zurücksetzen",style: TextStyle(color: Colors.black),),

          AlreadyHaveAnAccount(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
