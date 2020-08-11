import 'package:flutter/material.dart';

const kNormalTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w400,
  fontSize: 20.0,
);

const kHeadingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 40.0,
  fontWeight: FontWeight.w200,
);

const kSmallTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
);

const kTimeLimit = 30;

const kAppBackgroundColor = Color(0xff315064);

enum GameStatus {
  playing,
  won,
  lost,
  drawn,
}
