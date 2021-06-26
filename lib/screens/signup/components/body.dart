import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login/components/already_have_an_account.dart';
import 'package:login/components/rounded_button.dart';
import 'package:login/components/rounded_input_field.dart';
import 'package:login/components/rounded_password_field.dart';
import 'package:login/constants.dart';
import 'package:login/screens/login/login_screen.dart';
import 'package:login/screens/signup/components/background.dart';
import 'package:login/screens/signup/components/or_divider.dart';
import 'package:login/screens/signup/components/social_icons.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "SIGN UP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.03),
          Image.asset(
            "assets/images/signup.png",
            height: size.height * 0.35,
          ),
          RoundedInputField(
            hintText: "Your E-Mail",
            onChanged: (value) {},
          ),
          RoundedPasswordField(

          ),
          RoundedButton(
            text: "SIGN UP",
            press: () {},
          ),
          SizedBox(height: size.height * 0.03),

          AlreadyHaveAnAccount(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
          OrDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SocialIcon(
                path: "assets/icons/facebook.svg",
                press: () {},
              ),
              SocialIcon(
                path: "assets/icons/twitter.svg",
                press: () {},
              ),
              SocialIcon(
                path: "assets/icons/google.svg",
                press: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

