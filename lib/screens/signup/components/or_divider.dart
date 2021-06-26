import 'package:flutter/material.dart';
import 'package:login/constants.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height*0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          BuildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          Text("OR", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600)),
          BuildDivider(),
        ],
      ),
    );
  }
  Expanded BuildDivider(){
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}
