import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';

import 'package:messenger/provider/Chats.dart';

import 'package:provider/provider.dart';

import '../widgets/edit_Chat.dart';

class AddChat_page extends StatefulWidget {
  int index;
  Chat _chat;

  AddChat_page(this.index, this._chat);

  @override
  State<AddChat_page> createState() => _AddChat_pageState();
}

class _AddChat_pageState extends State<AddChat_page> {
  final _formKey = GlobalKey<FormState>();

  //TextEditingController title_controller = new TextEditingController();
  Chat get chat => widget._chat;

  bool edit_chat_pressed = false;

  @override
  Widget build(BuildContext context) {
    if (edit_chat_pressed == true &&
        widget.index <=
            Provider.of<Chats>(context, listen: false).chats.length) {
      //um SetState() called during build Probleme zu vermeiden
      Future.delayed(Duration(milliseconds: 100), () {
        EditChat().editChat(context, chat, widget.index);
        //Navigator.of(context).pop();
      });

      // Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: new AppBar(
        title: Text("add Chat"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      widget._chat.title = value;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Chat name...',
                    labelText: 'Chat',
                  ),
                  controller: TextEditingController(text: "${chat.title}"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a url';
                    } else {
                      widget._chat.image_url = value;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Image url...',
                    labelText: 'Image url',
                  ),
                  controller: TextEditingController(text: "${chat.image_url}"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        widget._chat.description = value;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Description...',
                      labelText: 'Description',
                    ),
                    controller:
                        TextEditingController(text: "${chat.description}")),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (widget.index >
                Provider.of<Chats>(context, listen: false).chats.length) {
              Provider.of<Chats>(context, listen: false).addChat(widget._chat);
              Navigator.of(context).pop();
            } else {
              setState(() {
                edit_chat_pressed = true;
              });
            }
          }
        },
      ),
    );
  }
}
