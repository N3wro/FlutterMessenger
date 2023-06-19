import 'dart:async';


import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';
import 'package:messenger/provider/Chats.dart';


import 'package:provider/provider.dart';



class DeleteMessage
{



  void deleteMessage(BuildContext context, Chat chat, message_key, index) async {


    showDialog(

        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(

            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [

                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('deleting Message'),
                ],
              ),
            ),
          );
        });

    Provider.of<Chats>(context, listen: false).deleteMessage(
        message_key, chat, index: index );


    await Future.delayed(const Duration(seconds: 3));


    Navigator.of(context).pop();
  }




}