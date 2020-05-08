import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MessageBubble.dart';

class MessageStream extends StatelessWidget {
 final Stream messageStreams;

 MessageStream({this.messageStreams, @required this.currentUserMail});

 final currentUserMail;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStreams,
      builder: (context, snaphot) {
        if (snaphot.hasData) {
          List<Widget> messageWidgets = [];
          final messages = snaphot.data.documents.reversed;
          for (var message in messages) {
            final String msgtxt = message.data['text'];
            final String msgsender = message.data['sender'];
            final messageBubbles = MessageBuble(
              istheSender: msgsender == currentUserMail,
              message: msgtxt,
              sender: msgsender,
            );
            messageWidgets.add(messageBubbles);
          }
          return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: messageWidgets,
                  reverse: true,
                ),
              ));
        } else {
          return MessageBuble(
            istheSender: true,
            message: "There's no message yet",
            sender: "",
          );
        }
      },
    );
  }
}