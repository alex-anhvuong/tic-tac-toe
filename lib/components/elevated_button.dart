import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

class ElevatedButton extends StatelessWidget {
  const ElevatedButton({
    Key key,
  }) : super(key: key);

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
        'Enter',
        style: kSmallTextStyle,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(),
          ),
        );
      },
    );
  }
}
