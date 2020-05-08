import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/MessageBubble.dart';
import 'package:flash_chat/components/MessageStream.dart';
import 'package:flash_chat/components/RoundIconButton.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

Firestore _firestore = Firestore.instance;
FirebaseUser loggedUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'Chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedUser = user;
        print('logged user ${loggedUser.email} + ${loggedUser.displayName}');
      } else {
        print('no user logged!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.blue));
    String messageText;

    void sendMessage() async {
      print('sending message ${messageText}');
      if(messageText == null || messageText.isEmpty){
        print('No message');
        return;
      }
      await _firestore
          .collection(kMessageCollection)
          .add({'text': messageText, 'sender': loggedUser.email,'username': loggedUser.displayName});
      setState(() {
        messageText = null;
        messageTextController.clear();
      });
    }

    void textChange(String value) {
      messageText = value;

    }

    Widget sendButton() => messageText != null && messageText.isNotEmpty ? EnabledButton(): DisabledButton();



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
                _firestore.collection(kMessageCollection).snapshots(),
                currentUserMail: loggedUser.email),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: messageTextController,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value){
                          textChange(value);
                        },
                        decoration: kMessageTextFieldDecoration.copyWith(
                            hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.75))),
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(FontAwesome5.paper_plane),onPressed: () {
                    sendMessage();
                  },color: Colors.white,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class DisabledButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundIconButton(
        elevation: 0,
        color: Colors.blue.withOpacity(0.50),
        iconcolor: Colors.white.withOpacity(0.25),
        icon: FontAwesome5.paper_plane);
  }
}
class EnabledButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundIconButton(
        elevation: 3,
        color: Colors.white,
        iconcolor: Colors.blue,
        icon: FontAwesome5.paper_plane);
  }
}

