import 'package:flutter/material.dart';

const kLogoTag = 'logo';
const kBorderRadius = 32.0;
const ksenderIcon = 'https://cdn.dribbble.com/users/1044993/screenshots/10636116/media/be2ea281d1b11aadd892e1393e9cec74.png';
const krecieverIcon = 'https://cdn.dribbble.com/users/1044993/screenshots/10494076/media/8c7e834295ac74556c6622c9dfc136bc.png';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
const kFormTextStyle = TextStyle(color: Colors.black,fontWeight: FontWeight.w500);
const kFormHintStyle = TextStyle(color: Colors.grey,fontWeight: FontWeight.w200);
const kMessageCollection = 'messages';
const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
  hintStyle: kFormHintStyle,
);
const kMessageContainerDecoration = BoxDecoration(
  color: Colors.blue,
  border: Border(
    top: BorderSide(color: Colors.white, width: 1.0),
  ),
);
