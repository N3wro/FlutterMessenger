import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';
import 'package:messenger/domain/Message.dart';
import 'package:messenger/page/addChat_page.dart';
import 'package:messenger/provider/Chats.dart';
import 'package:messenger/widgets/build_chat_listTile.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Chats> (
      create: (context) => Chats(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{

        },
        title: 'Flutter Messenger',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Kartal Messenger'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var loading = false;

  @override
  Future<void> didChangeDependencies() async {
    setState(() {
      loading = true;
    });


      await Provider.of<Chats>(context, listen: false).loadChat();
      setState(() {
        loading = false;
      });

  }

  void push_to_addChat_page() {
    List<Chat> chat_list =  Provider.of<Chats>(context, listen: false).chats;
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddChat_page(
                  chat_list.length+1,  Chat(Map(),"", "", ""))));
      // Provider.of<Chats>(context, listen:  false).addChat(new Chat(new HashMap(),'derp', 'https://static.wikia.nocookie.net/thewalkingfandomgerman/images/f/ff/Jackie_Chan.png/revision/latest?cb=20201029060505&path-prefix=de'));
    });
  }

  @override
  void initState() {
    Provider.of<Chats>(context, listen:  false).loadChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
        Consumer<Chats>(
        child: const Divider(), //------v
    builder: (context, contacts, child) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: RefreshIndicator(
    onRefresh: () {
    print('refreshing');
    return didChangeDependencies();
    },
           child: Build_chat_listTile())
    ),
    ),




      floatingActionButton: FloatingActionButton(
        onPressed: push_to_addChat_page,
        tooltip: 'Create Chat',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
