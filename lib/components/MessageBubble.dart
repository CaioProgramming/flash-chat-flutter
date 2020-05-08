import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MessageBuble extends StatelessWidget {
  final String message, sender;
  final bool istheSender;

  MessageBuble({this.message, this.sender,@required this.istheSender});

  BorderRadius chatBorder() {
    if (!istheSender) {
      return BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25));
    }
    return BorderRadius.only(
        bottomRight: Radius.circular(25),
        topRight: Radius.circular(25),
        bottomLeft: Radius.circular(25));
  }

  EdgeInsetsGeometry margin() =>
      istheSender ? EdgeInsets.only(left: 20) : EdgeInsets.only(right: 20);

  Color bubbleColor() =>
      istheSender ? Colors.blueAccent : Colors.grey.withOpacity(0.15);

  Color textColor() => istheSender ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment:
        istheSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            backgroundImage:
            NetworkImage(istheSender? ksenderIcon : krecieverIcon),
            backgroundColor: Colors.grey.withOpacity(0.10),
          ),
          Container(
            margin: margin(),
            child: Material(
                color: bubbleColor(),
                borderRadius: chatBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '$message',
                    style: TextStyle(fontSize: 16, color: textColor()),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              '$sender',
              style:
              TextStyle(fontSize: 12, color: Colors.grey.withOpacity(0.50)),
            ),
          ),
        ],
      ),
    );
  }
}
