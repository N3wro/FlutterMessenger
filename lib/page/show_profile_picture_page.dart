import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Show_profile_picture_page extends StatelessWidget {
  Chat _chat;

  Show_profile_picture_page(this._chat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: _chat.image_url,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.account_box,
                  ),
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _chat.title,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_chat.description),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Message amount: ${_chat.messages.values.length}"),
            ),
          ],
        ),
      ),
    );
  }
}
