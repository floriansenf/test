import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/components/rounded_button.dart';
import 'package:login/components/text_field_container.dart';
import 'package:login/constants.dart';
import 'package:login/screens/login/components/background.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Passwort zurücksetzen"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Background(
          child: ForgotPasswordContainer(),
        ),
      ),
    );
  }
}

class ForgotPasswordContainer extends StatefulWidget {
  const ForgotPasswordContainer({Key key}) : super(key: key);

  @override
  _ForgotPasswordContainerState createState() =>
      _ForgotPasswordContainerState();
}

class _ForgotPasswordContainerState extends State<ForgotPasswordContainer> {
  final myController1 = TextEditingController();
  Future<String> _future;

  @override
  void dispose() {
    myController1.dispose();
    super.dispose();
  }

  Future<String> forgotpw(String email) async {
    final response = await http.post(
      Uri.https('jsonplaceholder.typicode.com', 'albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    if (email == "flo") {
      return "success";
    } else {
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: size.height * 0.05,
          ),
          TextFieldContainer(
            child: TextField(
              controller: myController1,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "E-Mail",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          (_future == null)
              ? Container()
              : FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String response = snapshot.data.toString();
                      if (response == "success") {
                        return Text(
                            "Ein Link zum Zurücksetzen des Passworts wurde an deine E-Mail gesendet");
                      } else {
                        return Text("Überprüfe deine E-Mail");
                      }
                    }
                    return CircularProgressIndicator();
                  }),
          RoundedButton(
            text: "Bestätigungslink anfordern",
            press: () {
              String email = myController1.text;
              _future = forgotpw(email);
            },
          ),
        ]);
  }
}
