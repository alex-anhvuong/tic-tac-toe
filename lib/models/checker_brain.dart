import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/constants.dart';

class CheckerBrain {
  int currentMove;
  List<String> squareStateList;
  String winner, userName = 'Guest';
  // GameStatus gameStatus;
  Query stateStream;

  CheckerBrain() {
    stateStream =
        Firestore.instance.collection('game-states').orderBy('lastUploaded');
    // gameStatus = GameStatus.playing;
  }

  void updateSquareState(int id) {
    if (currentMove % 2 == 0)
      squareStateList[id] = "x";
    else
      squareStateList[id] = "o";

    currentMove++;

    if (checkGameResult() == GameStatus.won) {
      winner = userName;
    }

    pushGameState();
  }

  void deleteGameStates() async {
    await Firestore.instance
        .collection('game-states')
        .getDocuments()
        .then((qSnapshot) {
      for (DocumentSnapshot doc in qSnapshot.documents) {
        doc.reference.delete();
      }
    });
  }

  void createNewGame() {
    currentMove = 0;
    squareStateList = List.generate(9, (index) => "");
    winner = '';
  }

  void pushGameState() async {
    await Firestore.instance.collection('game-states').add({
      'move': currentMove,
      'squareStates': squareStateList,
      'winner': winner,
      'lastUploaded': FieldValue.serverTimestamp(),
    });
  }

  void setGameState(DocumentSnapshot stateSnapshot) {
    if (stateSnapshot == null) {
      createNewGame();
      pushGameState();
      return;
    }

    currentMove = stateSnapshot['move'];
    squareStateList = List.from(stateSnapshot['squareStates']);
    winner = stateSnapshot['winner'];
  }

  GameStatus checkGameResult() {
    for (int i = 0; i <= 2; i++) {
      if (squareStateList[i] != '' &&
          squareStateList[i] == squareStateList[i + 3] &&
          squareStateList[i] == squareStateList[i + 6]) return GameStatus.won;
    }

    for (int i = 0; i <= 6; i += 3) {
      if (squareStateList[i] != '' &&
          squareStateList[i] == squareStateList[i + 1] &&
          squareStateList[i] == squareStateList[i + 2]) return GameStatus.won;
    }

    if (squareStateList[0] != '' &&
        squareStateList[0] == squareStateList[4] &&
        squareStateList[0] == squareStateList[8]) return GameStatus.won;

    if (squareStateList[2] != '' &&
        squareStateList[2] == squareStateList[4] &&
        squareStateList[2] == squareStateList[6]) return GameStatus.won;

    if (currentMove == 9) return GameStatus.drawn;
    return GameStatus.playing;
  }
}
