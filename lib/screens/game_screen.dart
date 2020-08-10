import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/components/checker_board.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/models/checker_brain_provider.dart';

import 'package:timer_count_down/timer_count_down.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckerBrainProvider>(
      builder: (_, cbProvider, __) {
        return Scaffold(
          backgroundColor: kAppBackgroundColor,
          body: SafeArea(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Countdown(
                        controller: cbProvider.cdController,
                        seconds: kTimeLimit,
                        build: (_, double time) => Text(
                          '${(time / 60).floor().toStringAsFixed(0)} ${time / 60 > 0 ? ':' : ''} ${(time % 60 < 10) ? 0 : ''}${(time % 60).toStringAsFixed(0)}',
                          style: kHeadingTextStyle,
                        ),
                        onFinished: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'It\'s ${cbProvider.userName()} move',
                        style: kNormalTextStyle,
                      ),
                    ],
                  ),
                  CheckerBoard(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text('quit', style: kSmallTextStyle),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget getCheckerBoard() {
  //   print(checkerBrain.gameStatus);
  //   switch (checkerBrain.gameStatus) {
  //     case GameStatus.won:
  //       return Text("Win!");
  //     case GameStatus.lost:
  //       return Text("Lost!");
  //     default:
  //       return CheckerBoard(checkerBrain: checkerBrain);
  //   }
  // }
}
