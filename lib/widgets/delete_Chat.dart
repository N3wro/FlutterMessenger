import 'dart:async';


import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';
import 'package:messenger/provider/Chats.dart';


import 'package:provider/provider.dart';


class DeleteChat
{
  void deleteChat(BuildContext context, Chat chat) async {


    showDialog(

        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('deleting Chat'),
                ],
              ),
            ),
          );
        });

   Provider.of<Chats>(context, listen: false).delete_Chat(chat);

    await Future.delayed(const Duration(seconds: 3));

      Navigator.of(context).pop();
  }
}