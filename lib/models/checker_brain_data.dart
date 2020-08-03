import 'package:flutter/cupertino.dart';

class CheckerBrainData extends ChangeNotifier {
  int currentMove = 0;
  List<String> squareStateList = List.generate(9, (index) => "");

  void updateSquareState(int id) {
    if (currentMove % 2 == 0)
      squareStateList[id] = "x";
    else
      squareStateList[id] = "o";
    currentMove++;
    notifyListeners();
  }
}
