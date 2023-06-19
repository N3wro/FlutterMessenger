import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';

import 'package:messenger/page/addChat_page.dart';
import 'package:messenger/page/show_profile_picture_page.dart';
import 'package:messenger/provider/Chats.dart';

import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';


import '../widgets/build_message_listTile.dart';


class Build_chat_history extends StatefulWidget {
  final index;

  Build_chat_history(this.index, {Key? key}) : super(key: key);

  @override
  State<Build_chat_history> createState() => _Build_chat_historyState();
}

class _Build_chat_historyState extends State<Build_chat_history> {

  TextEditingController controller = TextEditingController();
  Chat chat_from_provider = Chat(Map(), "", "", "");
  var timer;

  @override
  void dispose() {
    // TODO: implement dispose

    timer.cancel();
    super.dispose();

  }

  @override
  void initState() {
  //  chat_from_provider= Provider.of<Chats>(context).chats.elementAt(widget.index);


  timer=  Timer.periodic(Duration(seconds: 5), (timer) async {
      await Provider.of<Chats>(context, listen: false)
          .loadMessages(chat_from_provider);
      print("loaded" + DateTime.now().toString());

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chat_from_provider =
        Provider.of<Chats>(context).chats.elementAt(widget.index);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Show_profile_picture_page(chat_from_provider)));
              },
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(300.0),
                child: CachedNetworkImage(
                  imageUrl: chat_from_provider.image_url,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.account_box,
                  ),
                  fit: BoxFit.cover,
                  width: 30,
                ),
              ),
            ),
          ],
        ),
        title: Text(chat_from_provider.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddChat_page(widget.index, chat_from_provider)));
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Build_message_listTile(chat_from_provider),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Message...',
                suffixIcon: IconButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      Provider.of<Chats>(context, listen: false)
                          .sendMessage(
                              controller.text,
                              Provider.of<Chats>(context, listen: false)
                                  .chats
                                  .elementAt(widget.index),
                              index: widget.index)
                          .whenComplete(() {
                        Provider.of<Chats>(context, listen: false).loadChat();
                        controller.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
