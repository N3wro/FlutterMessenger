import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';

import 'package:messenger/provider/Chats.dart';

import 'package:provider/provider.dart';




class EditChat{

  void editChat(BuildContext context, Chat chat, index) async {


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
                  Text('Editing Chat'),
                  Text('this could take some time'),

                ],
              ),
            ),
          );
        });

    //asynchrone Arbeit

    Provider.of<Chats>(context, listen: false).editChat(
         chat, index );


    await Future.delayed(const Duration(seconds: 10));

    //Zurück zum Homescreen navigieren
    Navigator.of(context).pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));


  }


}