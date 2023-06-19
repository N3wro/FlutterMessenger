
import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';

import 'delete_Message.dart';

class Build_message_listTile extends StatelessWidget{

  Chat chat;
  Build_message_listTile(this.chat);

  @override
  Widget build(BuildContext context) {
   return ListView.builder(
      padding: const EdgeInsets.only(top: 20.0),
      itemCount: chat.messages.values.length,
      itemBuilder: (context, index) {

        if (chat.messages.values.elementAt(index).isNotEmpty) {

          return Dismissible(

            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Card(
              color: Colors.red,
              child: ListTile(
                  trailing: Icon(
                    Icons.delete,
                    size: 30,
                  )),
            ),
            onDismissed: (direction) {

              DeleteMessage()
                  .deleteMessage(context,chat , chat.messages.keys.elementAt(index),
                  index );
            },
            child: Card(

              child: ListTile(

                title: Text("${chat.messages.values.elementAt(index)}"),
              ),
              elevation: 1,
            ),
          );
        } else {
          return SizedBox.shrink();
        }

      },
    );
  }

}