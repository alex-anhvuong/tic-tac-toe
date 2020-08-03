import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/components/checker_square.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/models/checker_brain_data.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckerBrainData(),
      child: Scaffold(
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
                        squareItem: Provider.of<CheckerBrainData>(context)
                            .squareStateList[index],
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
                Text('quit', style: kSmallTextStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
