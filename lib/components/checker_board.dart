import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/components/checker_square.dart';
import 'package:tic_tac_toe/models/checker_brain_provider.dart';

class CheckerBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckerBrainProvider>(
      builder: (_, cbProvider, __) {
        return Container(
          color: Colors.grey[600],
          child: StreamBuilder<QuerySnapshot>(
            stream: cbProvider.getCBStream(),
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

              cbProvider
                  .setGameState(gameStates.length > 0 ? gameStates.last : null);

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
                    squareItem: cbProvider.getItemState(index),
                    onPressed: () {
                      if (cbProvider.getItemState(index) == "") {
                        cbProvider.updateSquareState(index);
                      }
                    },
                  );
                },
                shrinkWrap: true,
              );
            },
          ),
        );
      },
    );
  }
}
