import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MessageBubble.dart';

class MessageStream extends StatelessWidget {
  final Stream messageStreams;
  final String currentUserId;

  MessageStream({this.messageStreams, @required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStreams,
      builder: (context, snaphot) {
        List<Widget> messageWidgets = [];
        final messages = snaphot.data.documents;
        for (var message in messages) {
          final Message msg = Message.toMessage(
            message.data,
            currentUserId,
            message.documentID,
          );
          final messageBubbles = MessageBuble(message: msg);
          messageWidgets.add(messageBubbles);
        }
        return Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: messageWidgets.isNotEmpty
                    ? ListView(
                        children: messageWidgets,
                        reverse: true,
                      )
                    : MessageBuble(message: Message.noMessages())));
      },
    );
  }
}
