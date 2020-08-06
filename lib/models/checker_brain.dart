import 'package:cloud_firestore/cloud_firestore.dart';

class CheckerBrain {
  int _currentMove;
  List<String> _squareStateList;
  Stream stateStream;

  int get currentMove => _currentMove;
  List<String> get squareStateList => _squareStateList;

  CheckerBrain() {
    stateStream =
        Firestore.instance.collection('game-brains').document('1').snapshots();
  }

  void updateSquareState(int id) async {
    if (_currentMove % 2 == 0)
      _squareStateList[id] = "x";
    else
      _squareStateList[id] = "o";

    _currentMove++;

    await Firestore.instance
        .collection('game-brains')
        .document('1')
        .updateData({
      'move': _currentMove,
      'squareStates': _squareStateList,
    });
  }

  void setGameState(DocumentSnapshot stateSnapshot) async {
    if (stateSnapshot.exists) {
      _currentMove = stateSnapshot['move'];
      _squareStateList = List.from(stateSnapshot['squareStates']);
    } else {
      _currentMove = 0;
      _squareStateList = List.generate(9, (index) => "");
      await Firestore.instance.collection('game-brains').document('1').setData({
        'move': _currentMove,
        'squareStates': _squareStateList,
      });
    }
  }
}
