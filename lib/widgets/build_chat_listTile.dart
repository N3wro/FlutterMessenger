
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:messenger/page/show_profile_picture_page.dart';
import 'package:messenger/provider/Chats.dart';
import 'package:provider/provider.dart';

import '../page/build_chat_history.dart';
import 'delete_Chat.dart';

class Build_chat_listTile extends StatefulWidget {
  @override
  State<Build_chat_listTile> createState() => _Build_chat_listTileState();
}



class _Build_chat_listTileState extends State<Build_chat_listTile> {
  @override
  Widget build(BuildContext context) {
    final chat_list = Provider.of<Chats>(context).chats;
    return ListView.builder(
        itemBuilder: (_, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Card(
              color: Colors.red,
              child: ListTile(
                trailing:
                  Icon(Icons.delete, size: 30,)
              ),
            ),
            key: UniqueKey(),
            onDismissed: (direction) {
              DeleteChat().deleteChat(context, chat_list.elementAt(index));
            },
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                                  builder: (context) =>
                          Build_chat_history(index)));
                },
                title: Text("${chat_list.elementAt(index).title }"),
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Show_profile_picture_page(
                                chat_list.elementAt(index))));
                  },
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: CachedNetworkImage(
                      imageUrl: chat_list.elementAt(index).image_url,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.account_box,),
                      fit: BoxFit.cover,
                      width: 30,
                    )
                  ),
                ),
              ),
              elevation: 2,
            ),
          );
        },
        itemCount: chat_list.length);
  }


}
