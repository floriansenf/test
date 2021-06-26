import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
class LoginController extends GetxController{
  var return_value = "".obs;
  static var client = new http.Client();
  var isLoading = false.obs;
  postrequest(String email, String password) async {
    try {
      isLoading(true);
      var header1 = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      };
      var body1 = jsonEncode(<String, String>{
        'email': email,
        'password': password,
      });
      var response =
      await client.get(Uri.parse("https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline")); //, headers: header1, body: body1
      if (response.statusCode == 200) {

        var json_msg = json.decode(response.body);
        var msg="success";//json_msg['msg']

        return_value.value=msg;
      } else {
        return_value.value = "error";
      }
    } finally {
      isLoading(false);
    }

  }

  login() async {
    try {
      isLoading(true);
      var response = await client.get(Uri.parse(
          "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"));
      if (response.statusCode == 200) {
        return_value.value = "missing-mail";
      } else {
        return_value.value = "error";
      }
    } finally {
      isLoading(false);
    }
  }
}