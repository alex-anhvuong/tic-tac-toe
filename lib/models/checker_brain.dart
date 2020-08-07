import 'package:cloud_firestore/cloud_firestore.dart';

class CheckerBrain {
  int _currentMove;
  List<String> _squareStateList;
  var stateStream;

  int get currentMove => _currentMove;
  List<String> get squareStateList => _squareStateList;

  CheckerBrain() {
    stateStream =
        Firestore.instance.collection('game-states').orderBy('lastUploaded');
  }

  void updateSquareState(int id) {
    if (_currentMove % 2 == 0)
      _squareStateList[id] = "x";
    else
      _squareStateList[id] = "o";

    _currentMove++;

    if (checkGameWin()) {
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
    _currentMove = 0;
    _squareStateList = List.generate(9, (index) => "");
  }

  void pushGameState() async {
    await Firestore.instance.collection('game-states').add({
      'move': _currentMove,
      'squareStates': _squareStateList,
      'lastUploaded': FieldValue.serverTimestamp(),
    });
  }

  void setGameState(DocumentSnapshot stateSnapshot) {
    if (stateSnapshot != null) {
      _currentMove = stateSnapshot['move'];
      _squareStateList = List.from(stateSnapshot['squareStates']);
    } else {
      createNewGame();
      pushGameState();
    }
  }

  bool checkGameWin() {
    for (int i = 0; i <= 2; i++) {
      if (_squareStateList[i] != '' &&
          _squareStateList[i] == _squareStateList[i + 3] &&
          _squareStateList[i] == _squareStateList[i + 6]) return true;
    }

    for (int i = 0; i <= 6; i += 3) {
      if (_squareStateList[i] != '' &&
          _squareStateList[i] == _squareStateList[i + 1] &&
          _squareStateList[i] == _squareStateList[i + 2]) return true;
    }

    if (_squareStateList[0] != '' &&
        _squareStateList[0] == _squareStateList[4] &&
        _squareStateList[0] == _squareStateList[8]) return true;

    if (_squareStateList[2] != '' &&
        _squareStateList[2] == _squareStateList[4] &&
        _squareStateList[2] == _squareStateList[6]) return true;

    if (_currentMove == 9) return true;
    return false;
  }
}
