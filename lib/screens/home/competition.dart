import 'package:flutter/material.dart';
import 'package:login/screens/login/components/background.dart';

import '../../constants.dart';
import 'data.dart';
class Two extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(

        child:Column(

          children: [
            AppBar(automaticallyImplyLeading: false,centerTitle: true,backgroundColor: kPrimaryColor,title: Text("Verkaufte Produkte 2020")),
            Expanded(

              child:  _buildList(key: "key1", string: "List1: "),)

          ],
        )
    );
  }
}

Widget _buildList({String key, String string}) {
  return ListView.builder(
    key: PageStorageKey(key),
    itemCount: CompetitionModel.items.length,
    itemBuilder: (_, i) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: LimitedBox(
          maxHeight: 48,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                child: Stack(
                  children: [

                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CompetitionModel.items[i].color, //
                        ),

                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child:  Text('${CompetitionModel.items[i].position}',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black38),),
                    )

                  ],
                ),
              ),


              SizedBox(width: 24),
              Expanded(
                child: Text(CompetitionModel.items[i].name,style: TextStyle(fontSize: 17),),
              ),
              SizedBox(width: 24),
              Text('${CompetitionModel.items[i].revenue}',style: TextStyle(fontSize: 17))
            ],
          ),
        ),
      );
    },
    //ListTile(title: Text("${string} ${i}"))
  );
}