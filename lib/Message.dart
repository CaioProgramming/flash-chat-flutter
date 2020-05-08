import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Message {
  String text, id, sender, senderUID, currentUserUID;
  Timestamp data;
  bool istheSender() => currentUserUID == senderUID;

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderUID': senderUID,
      'sender': sender,
      'data': data
    };
  }

  static Message toMessage(Map<String, dynamic> map, String uid, String key) {
    print('converting map($map) to Message ');
    final String text = map['text'];
    final String sender = map['sender'];
    final String senderUID = map['senderUID'];
    final Timestamp data = map['data'];
    return Message(
        text: text,
        sender: sender,
        senderUID: senderUID,
        data: data,
        id: key,
        currentUserUID: uid);
  }



  String hour ()  {
    DateTime date = data.toDate();
    if(date.minute == 0){
      return '${date.hour}h';
    }
    return '${date.hour}:${date.minute}';
  }


  bool emptyMessage() {
    return this.id.isEmpty &&
        this.currentUserUID.isEmpty &&
        this.senderUID.isEmpty &&
        this.sender.isEmpty;
  }

  Message(
      {this.text,
        this.id,
        this.sender,
        this.data,
        this.senderUID,
        this.currentUserUID}) {
    print(
        'Message/$id{\nmessage:$text\nsender($senderUID):$sender\ncurrentUser:$currentUserUID\ndata:$data\n}');
  }

  Message.sender(
      {@required this.text,
        @required this.sender,
        @required this.senderUID,
        @required this.data}) {
    print(
        'Message:\nmessage:$text\nsender($senderUID):$sender\ncurrentUser:$currentUserUID\ndata:$data');
  }
  static Message noMessages() {
    return Message(
        text: 'There\'s no messages.',
        sender: '',
        currentUserUID: '',
        data: null,
        id: '',
        senderUID: '');
  }
}
