import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login/constants.dart';
import 'package:login/screens/login/components/background.dart';

class Three extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
          children: [
            AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: kPrimaryColor,
                title: Text("Ziele & Awards")),
            Card(
              margin: EdgeInsets.fromLTRB(0,15, 0, 0),
              color: kPrimaryLightColor,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mitarbeiter des Monats im Januar", style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),),
                    Text("Alex Müller mit 72.000€ Umsatz",
                      style: TextStyle(color: Colors.black, fontSize: 16),)
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(0,15, 0, 0),
              color: kPrimaryLightColor,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Februar Ziel", style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),),
                    Text("Umsatz von 50.000€, Fehlend: 17.560€",
                      style: TextStyle(color: Colors.black, fontSize: 16),)
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text("Starte los und gewinne im Februar eine Magnum Flasche Dom Perignon",
                textAlign: TextAlign.center, style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,),),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child:            SvgPicture.asset(

                "assets/icons/rocket.svg",
                width: 200,
                height: 200,
                color: kPrimaryLightColor,
              ),
            )

          ],
        ));
  }
}
