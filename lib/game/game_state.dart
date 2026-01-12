
import 'package:flutter/foundation.dart';

class GameState extends ChangeNotifier {
  int coins = 0;

  void addCoins(int value) {
    coins += value;
    notifyListeners();
  }
}
