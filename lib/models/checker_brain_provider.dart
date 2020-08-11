import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe/models/checker_brain.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../constants.dart';

class CheckerBrainProvider extends ChangeNotifier {
  CheckerBrain _cBrain = CheckerBrain();
  CountdownController cdController = CountdownController();
  GameStatus gameStatus;

  void updateUserName(String value) {
    value != '' ? _cBrain.userName = value : _cBrain.userName = 'Guest';
    notifyListeners();
  }

  String userName() => _cBrain.userName;

  Stream<QuerySnapshot> getCBStream() => _cBrain.stateStream.snapshots();

  void setGameState(DocumentSnapshot ds) => _cBrain.setGameState(ds);

  String getItemState(int index) => _cBrain.squareStateList[index];

  void updateSquareState(int index) {
    _cBrain.updateSquareState(index);
    cdController.onRestart();
  }

  void resetGameStates() => _cBrain.deleteGameStates();

  void setGameStatus() {
    if (_cBrain.winner != '' && _cBrain.winner == _cBrain.userName)
      gameStatus = GameStatus.won;
    else if (_cBrain.winner != '' && _cBrain.winner != _cBrain.userName)
      gameStatus = GameStatus.lost;
    else if (_cBrain.winner == '' && _cBrain.currentMove == 9)
      gameStatus = GameStatus.drawn;
    else
      gameStatus = GameStatus.playing;
  }
}
