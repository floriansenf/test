import 'package:flutter/material.dart';
import 'package:login/screens/home/chat.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../constants.dart';

class StreamAPI {
  static StreamChatClient client = StreamChatClient(
    apiKey,
    logLevel: Level.INFO,
  );

  void sendmessage(Channel channel) async {
    final message = Message(
        text:
            '@Josh I told them I was pesca-pescatarian. Which is one who eats solely fish who eat other fish.');
    await channel.sendMessage(message);
  }

  void deletemessage(Message message) async {
    // 2. Parameter hard(komplett gelöscht) or soft(als "deleted" angezeigt)
    await client.deleteMessage(message);
  }

  void loadgroupmembers(Channel channel) async {
    QueryMembersResponse response = await channel.queryMembers(); //{}, sort, {}
    List<Member> members = response.members;
  }

  void addmember(Channel channel, List<String> ids, Message message) async {
    channel.addMembers(ids, message); // message für ist der Gruppe beigetreten
  }

  void removeMember(Channel channel, List<String> ids) async {
    channel.removeMembers(ids); //["id1","id2"]
  }

  void addMember(Channel channel, List<String> ids) async {
    channel.removeMembers(ids); //["id1","id2"]
  }

  void createChannel(
      String groupname, String avatar, List<String> members) async {
    client.channel(
      "messaging",
      id: "1232123",
      extraData: {
        "name": groupname,
        "image": avatar,
        "members": members, //["member_id1", "member_id2"]
      },
    );
  }

  void updateChannelAvatar(
      String groupname, String avatar, Channel channel) async {
    await channel.updatePartial({
      "set": {"image": avatar}
    });
  }

  void updateChannelAvatarname(
      String groupname, String name, Channel channel) async {
    await channel.updatePartial({
      "set": {"name": name}
    });
  }

  void deleteChannel(Channel channel) async {
    channel.delete();
  }

  void sendimage(
      AttachmentFile image, String channelId, String channelType) async {
    var attachment = Attachment();
    client.sendImage(image, channelId, channelType).then((response) {
      // Successful upload, you can now attach this image
      // to an message that you then send to a channel
      final imageUrl = response.file;
      attachment = attachment.copyWith(
        type: 'image',
        imageUrl: imageUrl,
      );
      final message = Message(attachments: [attachment]);
      client.sendMessage(message, channelId, channelType);
    }).catchError((error, stk) {
      // Handle error
    });
  }

  AttachmentFile file = AttachmentFile(path: "/nigga/schmauß");

  void sendfile(
      AttachmentFile file, String channelId, String channelType) async {
    var attachment = Attachment();
    await client.sendFile(
      file,
      channelId,
      channelType,
      onSendProgress: (sent, total) {
        // Handle the send progress
        attachment = attachment.copyWith(
          uploadState: UploadState.inProgress(
            uploaded: sent,
            total: total,
          ),
        );
      },
    ).then((response) {
      // Successful upload, you can now attach this file
      // to an message that you then send to a channel
      final fileUrl = response.file;
      attachment = attachment.copyWith(
        type: 'file',
        assetUrl: fileUrl,
        uploadState: UploadState.success(),
      );
      final message = Message(attachments: [attachment]);
      client.sendMessage(message, channelId, channelType);
    }).catchError((error, stk) {
      // Handle error
      attachment = attachment.copyWith(
        uploadState: UploadState.failed(error: error),
      );
    });
  }

  void starttyping(Channel channel) async {
    await channel.keyStroke("1");
    Stream<Event> event = channel.on("typing.start");
    event.first.then((value) => {
          //typing
        });
    /* channel.on('typing.start', (event)  => {
     print(' started typing'); //${event.user.name}
    }); */
  }

  void stoptyping(Channel channel) async {
    await channel.stopTyping("1");
    Stream<Event> event = channel.on("typing.stop");
    event.first.then((value) => {
          //typing
        });
    /*  channel.on('typing.stop', (event) => {
      print(' stopped typing');
    }); */
  }

  void logout() async {
    await client.disconnect();
  }

  ChannelsBloc channelsBloc() {
    final channelListController = ChannelListController();

    return ChannelsBloc(
      child: ChannelListCore(
        channelListController: channelListController,
        filter: {'type': 'messaging'},
        emptyBuilder: (BuildContext context) {
          return Container();
        },
        loadingBuilder: (BuildContext context) {
          return CircularProgressIndicator();
        },
        errorBuilder: (BuildContext context, dynamic error) {
          return Center(
            child:
                Text('Oh no, something went wrong. Please check your config.'),
          );
        },
        listBuilder: (BuildContext context, List<Channel> channels) =>
            LazyLoadScrollView(
          onEndOfPage: () async {
            channelListController.paginateData();
          },
          child: ListView.builder(
            itemCount: channels.length,
            itemBuilder: (BuildContext context, int index) {
              final _item = channels[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StreamChannel(
                        channel: _item,
                        child: One(),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController _controller;
  ScrollController _scrollController;
  final messageListController = MessageListController();

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _updateList() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: LazyLoadScrollView(
              onEndOfPage: () async {
                messageListController.paginateData();
              },
              child: MessageListCore(
                loadingBuilder: (BuildContext context) {
                  return Center(
                    child: SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                emptyBuilder: (BuildContext context) {
                  return Center(
                    child: Text('Nothing here yet'),
                  );
                },
                errorWidgetBuilder: (BuildContext context, error) {
                  return Text("Es ist ein Fehler aufgetreten");
                },
                messageListBuilder:
                    (BuildContext context, List<Message> messages) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      final item = messages[index];
                    //  item.type
                      final client = StreamChatCore.of(context).client;
                      if (item.user.id == client.uid) {


                        if(item.type=="image"){
                          String imageurl=item.attachments.first.assetUrl;
                        }else if(item.type=="file"){
                          String fileurl="";//item.attachments.first.fileurl;
                        }else{
                          // Text
                        }
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.text),
                          ),
                        );
                      } else {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.text),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: (){
                    // filepicker
                    print("Foto auswählen");
                  },
                  icon: Icon(Icons.add,size: 15,),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                Material(
                  type: MaterialType.circle,
                  color: Colors.blue,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () async {
                      if (_controller.value.text.isNotEmpty) {
                        await channel.sendMessage(
                          Message(text: _controller.value.text),
                        );
                        _controller.clear();
                        _updateList();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension on StreamChatClient {
  /// Fetches the current user id.
  String get uid => state.user.id;
}

extension on Channel {
  /// Fetches the name of the channel by accessing [extraData] or [cid].
  String get name {
    final _channelName = extraData['name'];
    if (_channelName != null) {
      return _channelName;
    } else {
      return cid;
    }
  }
}
