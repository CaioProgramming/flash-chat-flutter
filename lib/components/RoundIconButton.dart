import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Color color, iconcolor;
  final Function onClick;
  final IconData icon;
  final double elevation;
  RoundIconButton(
      {this.color, this.iconcolor, @required this.onClick, this.icon,this.elevation});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: iconcolor,
      ),
      elevation: elevation,
      disabledElevation: 1,
      constraints: BoxConstraints.tightFor(width: 56, height: 56),
      shape: CircleBorder(),
      fillColor: color,
      onPressed: onClick,
    );
  }
}
