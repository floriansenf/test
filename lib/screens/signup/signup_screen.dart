import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:login/components/rounded_button.dart';
import 'package:login/components/rounded_input_field.dart';
import 'package:login/components/rounded_password_field.dart';
import 'package:login/screens/login/components/background.dart';
import 'package:http/http.dart' as http;
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: null,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/signup.png",
                height: size.height * 0.35,
              ),
              RegistrationContainer(),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationContainer extends StatefulWidget {
  const RegistrationContainer({Key key}) : super(key: key);

  @override
  _RegistrationContainerState createState() => _RegistrationContainerState();
}

class _RegistrationContainerState extends State<RegistrationContainer> {
  final _formkey = GlobalKey<FormState>();
  Future<String> _future;
  final controller1=new TextEditingController();
  final controller2=new TextEditingController();
  final controller3=new TextEditingController();
  final controller4=new TextEditingController();
  Future<bool> connection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
  Future<String> singup(String name,String email, String password,String verification) async {
    final response = await http.post(
      Uri.https('jsonplaceholder.typicode.com', 'albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'verification':verification,
      }),
    );
    if (email == "flo") {
      return "success";
    } else {
      return "error";
    }
  }
  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedInputField(
                hintText: "Name",
                controller: controller1,
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "E-Mail",
                icon: Icons.mail_rounded,
                controller: controller2,
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                controller: controller3,
              ),
              RoundedInputField(
                hintText: "Verifizierungscode",
                icon: Icons.lock,
                controller: controller4,
                onChanged: (value) {},
              ),
              (_future==null) ? RoundedButton(
                text: "Account erstellen",
                press: () {
                  connection().then(
                        (value) {
                      connection().then((value) {
                        if (value) {
                          if (_formkey.currentState.validate()) {
                            setState(() {
                                String name = controller1.text;
                                String email= controller2.text;
                                String password= controller3.text;
                                String verification= controller3.text;
                                _future = singup(name, email, password, verification);
                              },
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Es konnte keine Verbindung hergestellt werden"),
                          ));
                        }
                      });
                    },
                  );
                },
              ): FutureBuilder(future: _future,builder: (context, snapshot){
                if(snapshot.hasData){
                  String response = snapshot.data.toString();
                  if(response=="success"){

                  }
                  if(response=="email vergeben"){

                  }
                  if(response=="falscher code"){

                  }
                }
                return CircularProgressIndicator();
              })
            ],
          )
        ],
      ),
    );
  }
}
