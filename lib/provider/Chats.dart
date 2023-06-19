import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:messenger/domain/Message.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../domain/Chat.dart';

class Chats with ChangeNotifier {
  List<Chat> _chats = [];

  List<Message> messages = [];

  List<Chat> get chats => _chats;

  String database_url='https://wahl-133f5-default-rtdb.europe-west1.firebasedatabase.app/';

  Future<void> loadChat() async {
    final uri = Uri.parse(
        database_url+'/chatlist.json');
    final response = await http.get(uri);
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (body.isNotEmpty) {
      _chats = body.entries
          .map((entry) => Chat.fromJson(entry.key, entry.value))
          .toList();
    }
    else
      {
        _chats.clear();
      }
    notifyListeners();
  }

  Future<void> addChat(Chat chat) async {

    //Chatlist erstellen
    final uri = Uri.parse(
        database_url+'/chatlist.json');

    final response_post = await http.post(
      uri,
      body: jsonEncode(chat.toJson()),
    );

    final body = jsonDecode(response_post.body);

    chat.id = body['name'];

    loadChat();
    notifyListeners();
  }

  Future<void> editChat(Chat chat, int index) async {

    delete_Chat(chat);
    await Future.forEach([chat], (element) => addChat(chat));

    if (chat.messages.isNotEmpty)
    {
      //warten bis eine Nachricht in der Datenbank ist
      await Future.forEach(chat.messages.values, <String>(element) => sendMessage(element, chat));

    }
    loadChat();

    notifyListeners();
  }

  Future<void> delete_Chat(Chat chat) async {
    final uri = Uri.parse(
        database_url+'/chatlist/${chat.id}.json');

    await http.delete(
      uri,
      body: jsonEncode(chat.toJson()),
    );

    notifyListeners();
    loadChat();
  }

  deleteMessage(String message_key,  Chat chat, {int index = -1}) async {

    final uri = Uri.parse(
        database_url+'/chatlist/${chat.id}/messages/${message_key}.json');
     await http.delete(
        uri,
        body: jsonEncode(chat.toJsonMessage_key(message_key)),
      );

      chat.messages.remove(message_key);

      loadChat();
      notifyListeners();
  }

  getChat(String id)
  {
    return chats.singleWhere((element) => element.id == id);
  }



  Future<void>  sendMessage(String message, Chat chat, {int index = -1}) async {

      final uri = Uri.parse(
          database_url+'/chatlist/${chat.id}/messages.json');

      await http.post(
        uri,
        body: jsonEncode(chat.toJsonMessage(message))
      );

      notifyListeners();

  }

  Future<void>  loadMessages( Chat chat, {int index=-1}) async {

    final uri = Uri.parse(
        database_url+'/chatlist/${chat.id}/messages.json');
    final response = await http.get(
        uri);

    //response ist da!
  final body = jsonDecode(response.body) as LinkedHashMap<String, dynamic>;

    chat.messages = Map.from(body.map((key, value) {

      return MapEntry(
          key.toString(),
          value.values
              .toString()
              .substring(1, value.values.toString().length - 1));

    }));

    notifyListeners();
  }


}
