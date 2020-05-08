import 'package:flash_chat/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldDecoration{
  final String hintText;
  final double borderRadius;
  final Color enabledColor,defaultColor,focusedColor;

  TextFieldDecoration({this.hintText, this.borderRadius, this.enabledColor,
    this.defaultColor, this.focusedColor});

  OutlineInputBorder defaultBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius));

  OutlineInputBorder enabledBorder() => OutlineInputBorder(
        borderSide: BorderSide(color: enabledColor, width: 1.0));

  OutlineInputBorder focusedBorder() => OutlineInputBorder(
        borderSide: BorderSide(color: focusedColor, width: 1.0));





  InputDecoration decoration(){
    return InputDecoration(
      hintStyle: kFormHintStyle,
      hintText: hintText,
      contentPadding:
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: defaultBorder(),
      enabledBorder: enabledBorder(),
      focusedBorder: focusedBorder(),
    );
  }


}