import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/checker_square.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/models/checker_brain.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  CheckerBrain checkerBrain = CheckerBrain();

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    '1:32',
                    style: kHeadingTextStyle,
                  ),
                  Text(
                    'It\'s your move',
                    style: kNormalTextStyle,
                  ),
                ],
              ),
              Container(
                color: Colors.grey[600],
                child: StreamBuilder<QuerySnapshot>(
                  stream: checkerBrain.stateStream.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    if (!snapshot.hasData) {
                      return Text("Loading data");
                    }

                    List<DocumentSnapshot> gameStates = snapshot.data.documents;

                    checkerBrain.setGameState(
                        gameStates.length > 0 ? gameStates.last : null);

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return CheckerSquare(
                          id: index,
                          squareItem: checkerBrain.squareStateList[index],
                          onPressed: () {
                            if (checkerBrain.squareStateList[index] == "") {
                              checkerBrain.updateSquareState(index);
                            }
                          },
                        );
                      },
                      shrinkWrap: true,
                    );
                  },
                ),
              ),
              Text('quit', style: kSmallTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
