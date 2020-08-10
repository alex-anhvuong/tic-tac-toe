import 'package:cloud_firestore/cloud_firestore.dart';

class CheckerBrain {
  int currentMove;
  List<String> squareStateList;
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

    if (checkGameWin()) {
      // gameStatus = GameStatus.won;
      createNewGame();
      deleteGameStates();
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
  }

  void pushGameState() async {
    await Firestore.instance.collection('game-states').add({
      'move': currentMove,
      'squareStates': squareStateList,
      'lastUploaded': FieldValue.serverTimestamp(),
    });
  }

  void setGameState(DocumentSnapshot stateSnapshot) {
    if (stateSnapshot != null) {
      currentMove = stateSnapshot['move'];
      squareStateList = List.from(stateSnapshot['squareStates']);
    } else {
      createNewGame();
      pushGameState();
    }
  }

  bool checkGameWin() {
    for (int i = 0; i <= 2; i++) {
      if (squareStateList[i] != '' &&
          squareStateList[i] == squareStateList[i + 3] &&
          squareStateList[i] == squareStateList[i + 6]) return true;
    }

    for (int i = 0; i <= 6; i += 3) {
      if (squareStateList[i] != '' &&
          squareStateList[i] == squareStateList[i + 1] &&
          squareStateList[i] == squareStateList[i + 2]) return true;
    }

    if (squareStateList[0] != '' &&
        squareStateList[0] == squareStateList[4] &&
        squareStateList[0] == squareStateList[8]) return true;

    if (squareStateList[2] != '' &&
        squareStateList[2] == squareStateList[4] &&
        squareStateList[2] == squareStateList[6]) return true;

    if (currentMove == 9) return true;
    return false;
  }
}
