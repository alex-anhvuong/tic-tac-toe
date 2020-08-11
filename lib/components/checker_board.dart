import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/components/checker_square.dart';
import 'package:tic_tac_toe/components/elevated_button.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/models/checker_brain_provider.dart';

class CheckerBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckerBrainProvider>(
      builder: (_, cbProvider, __) {
        return StreamBuilder<QuerySnapshot>(
          stream: cbProvider.getCBStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            if (!snapshot.hasData) {
              // TODO: Add a Loader Indicator here
              return Text("Loading data");
            }

            List<DocumentSnapshot> gameStates = snapshot.data.documents;

            cbProvider
                .setGameState(gameStates.length > 0 ? gameStates.last : null);

            cbProvider.setGameStatus();

            if (cbProvider.gameStatus != GameStatus.playing) {
              cbProvider.cdController.onPause();

              return Column(
                children: [
                  getResultText(cbProvider.gameStatus),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    text: 'Play again?',
                    onPressed: () {
                      cbProvider.gameStatus = GameStatus.playing;
                      cbProvider.resetGameStates();
                      cbProvider.cdController.onResume();
                    },
                  ),
                ],
              );
            }

            return Container(
              color: Colors.grey[600],
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return CheckerSquare(
                    id: index,
                    squareItem: cbProvider.getItemState(index),
                    onPressed: () {
                      if (cbProvider.getItemState(index) == "") {
                        cbProvider.updateSquareState(index);
                      }
                    },
                  );
                },
                shrinkWrap: true,
              ),
            );
          },
        );
      },
    );
  }

  Text getResultText(GameStatus result) {
    String text;
    switch (result) {
      case GameStatus.won:
        text = 'You won!';
        break;
      case GameStatus.lost:
        text = 'Sorry. Defeat :(';
        break;
      default:
        text = 'It\'s a draw!';
        break;
    }

    return Text(
      text,
      style: kHeadingTextStyle,
    );
  }
}
