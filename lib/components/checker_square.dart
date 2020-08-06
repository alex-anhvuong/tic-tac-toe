import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants.dart';

class CheckerSquare extends StatelessWidget {
  final int id;
  final String squareItem;
  final Function onPressed;

  CheckerSquare({this.id, this.squareItem, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: kAppBackgroundColor,
        child: getSquareIcon(),
      ),
    );
  }

  Icon getSquareIcon() {
    if (this.squareItem == "") return null;
    if (this.squareItem == "x")
      return Icon(
        Icons.clear,
        size: 75.0,
        color: Colors.blue,
      );
    return Icon(
      Icons.radio_button_unchecked,
      size: 60.0,
      color: Colors.pink[200],
    );
  }
}
