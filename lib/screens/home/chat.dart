import 'package:flutter/material.dart';
import 'package:login/screens/login/components/background.dart';
import 'package:login/stream_api/stream_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../constants.dart';
import 'data.dart';

class One extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
      children: [

        Expanded(
          child: ChatList(buildContext: context),
        ),
      ],
    ));
  }
}

class ChatList extends StatefulWidget {
  final BuildContext buildContext;

  const ChatList({
    Key key,
    this.buildContext,
  }) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {

  return FutureBuilder(
      future: _buildList(widget.buildContext, widget.key),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
         if(snapshot.hasData){
           return snapshot.data;
         }else {
           return CircularProgressIndicator();
         }
    });
   
  }
}

Future<Widget> _buildList(BuildContext buildContext,Key key) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userToken=prefs.getString("userToken");

  await StreamAPI.client.connectUser(
    User(id: 'super-band-9',extraData: {"name":"Adolf Hitler","image":"https://www.image.com"}),
    userToken,
  );
  return ListView.builder(
    key: PageStorageKey("123"),
    itemCount: ChatModel.items.length,
    physics: const AlwaysScrollableScrollPhysics(),
    itemBuilder: (_, i) {
      return Card(
        child: InkWell(
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(("" != null) ? ChatModel.items[i].titel : '-',
                        style:
                            TextStyle(color: Colors.grey[900], fontSize: 16)),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        "" != null
                            ? ChatModel.items[i].message
                            : 'No desription',
                        style: TextStyle(fontSize: 14, color: Colors.grey[750]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                  ("frank" != null)
                                      ? ChatModel.items[i].sender
                                      : '',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(buildContext)
                                      .textTheme
                                      .caption)),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.remove_red_eye_rounded,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                      ("35" != null)
                                          ? ' ${ChatModel.items[i].viewed} Personen' //${repo.watchersCount}
                                          : '0 ',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(buildContext)
                                          .textTheme
                                          .caption),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Text(
                                  ("detusch" != null)
                                      ? ChatModel.items[i].date
                                      : '',
                                  textAlign: TextAlign.end,
                                  style: Theme.of(buildContext)
                                      .textTheme
                                      .caption)),
                        ],
                      ),
                    ),
                  ]),
            )),
      );
    },
    //ListTile(title: Text("${string} ${i}"))
  );
}
