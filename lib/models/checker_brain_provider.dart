import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe/models/checker_brain.dart';
import 'package:timer_count_down/timer_controller.dart';

class CheckerBrainProvider extends ChangeNotifier {
  String userName = 'Guest';
  CheckerBrain _cBrain = CheckerBrain();
  CountdownController cdController = CountdownController();

  void updateUserName(String value) {
    value != '' ? userName = value : userName = 'Guest';
    notifyListeners();
  }

  Stream<QuerySnapshot> getCBStream() {
    return _cBrain.stateStream.snapshots();
  }

  void setGameState(DocumentSnapshot ds) {
    _cBrain.setGameState(ds);
  }

  String getItemState(int index) {
    return _cBrain.squareStateList[index];
  }

  void updateSquareState(int index) {
    _cBrain.updateSquareState(index);
    cdController.onRestart();
  }
}
