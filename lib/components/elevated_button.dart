import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants.dart';

class ElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  ElevatedButton({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 10.0,
      fillColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: kSmallTextStyle,
      ),
      onPressed: onPressed,
    );
  }
}
