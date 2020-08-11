import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/components/elevated_button.dart';
import 'package:tic_tac_toe/models/checker_brain_provider.dart';

import 'game_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckerBrainProvider>(
      builder: (_, cbProvider, __) {
        return Scaffold(
          backgroundColor: kAppBackgroundColor,
          body: SafeArea(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Tic Tac Toe',
                          style: kHeadingTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.clear,
                              size: 100.0,
                              color: Colors.blue,
                            ),
                            Icon(
                              Icons.radio_button_unchecked,
                              color: Colors.pink[300],
                              size: 80.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Enter your name:',
                          style: kNormalTextStyle,
                        ),
                        TextField(
                          onChanged: (value) {
                            cbProvider.updateUserName(value);
                          },
                          style: kSmallTextStyle,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            fillColor: Color(0xff47687d),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameScreen(),
                              ),
                            );
                          },
                          text: 'Enter',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
