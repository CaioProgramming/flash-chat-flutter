import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MessageBuble extends StatelessWidget {
  final Message message;
  MessageBuble({this.message});
  BorderRadius chatBorder() {
    if (message.istheSender()) {
      return BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(2),
          bottomRight: Radius.circular(25));
    }
    return BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
        bottomLeft: Radius.circular(25));
  }

  AnimationController controller;

  EdgeInsetsGeometry margin() => message.istheSender()
      ? EdgeInsets.only(left: 20)
      : EdgeInsets.only(right: 20);

  Color bubbleColor() =>
      message.istheSender() ? Colors.blueAccent : Colors.grey.withOpacity(0.15);

  Color textColor() => message.istheSender() ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: message.istheSender()
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: <Widget>[
//          CircleAvatar(
//            radius: 25,
//            backgroundImage:
//            NetworkImage(istheSender? ksenderIcon : krecieverIcon),
//            backgroundColor: Colors.grey.withOpacity(0.10),
//          ),
        Container(
          child: GestureDetector(
            child: Material(
                color: bubbleColor(),
                borderRadius: chatBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TyperAnimatedTextKit(
                    text: ['${message.text}'],
                    isRepeatingAnimation: message.emptyMessage(),
                    speed: message.emptyMessage() ? Duration(seconds: 1): Duration(milliseconds: 500),
                    textStyle: TextStyle(color: textColor()),
                  ),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            '${message.sender}',
            style:
                TextStyle(fontSize: 12, color: Colors.grey.withOpacity(0.50)),
          ),
        ),
      ],
    );
  }
}
