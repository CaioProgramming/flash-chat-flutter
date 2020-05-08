import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Message.dart';
import 'package:flash_chat/components/MessageStream.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

Firestore _firestore = Firestore.instance;
FirebaseUser loggedUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'Chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 1),vsync: this);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final  Map<String, Object>routeData = ModalRoute.of(context).settings.arguments;
    print(routeData);
    loggedUser = routeData['user'];
    String messageText;
    Timestamp now() => Timestamp.fromDate(DateTime.now());
    void sendMessage() async {
      print('sending message $messageText');
      if(messageText == null || messageText.isEmpty || loggedUser.uid == null){
        print('No message or user logged!');
        return;
      }
      print(loggedUser.uid);
      Message message = Message.sender(senderUID: loggedUser.uid,data: now(),sender: loggedUser.displayName,text: messageText);
       await _firestore
          .collection(kMessageCollection)
          .add(message.toMap());
      setState(() {
        messageText = null;
        messageTextController.clear();
      });
    }
    void textChange(String value) {
      messageText = value;

    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close,color: Colors.black,),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        centerTitle: true,
        title: Text('⚡️Chat',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 32),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              messageStreams:
              _firestore.collection(kMessageCollection).orderBy('data',descending: true).snapshots(),
              currentUserId: loggedUser.uid,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                elevation:1,
                borderRadius: BorderRadius.circular(kBorderRadius),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: messageTextController,
                            style: TextStyle(color: Colors.black),
                            onChanged: (value){
                              textChange(value);
                            },
                            decoration: kMessageTextFieldDecoration.copyWith(
                                hintStyle:
                                TextStyle(color: Colors.black.withOpacity(0.25))),
                          ),
                        ),
                      ),
                      IconButton(icon: Icon(FontAwesome5Solid.paper_plane),onPressed: () {
                        sendMessage();
                      },color: Colors.blue,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


