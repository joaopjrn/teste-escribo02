import 'package:bonfire/base/bonfire_game_interface.dart';
import 'package:flutter/material.dart';
import 'package:pac_ninja/items/items.dart';
import 'package:pac_ninja/ui/end_screen.dart';

class GameState with ChangeNotifier {
  int _points = 0;

  int get points => _points;

  void updatePoints(int amt, BonfireGameInterface gameRef) {
    int togo = gameRef.componentsByType<Sushi>().toList().length;
    if (togo <=1) {
      gotoEnd(gameRef.context);
    }
    _points += amt;
    notifyListeners();
  }

  gotoEnd(ctx) {
    Navigator.of(ctx)
    .pushReplacement(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) {
          return const EndScreen();
        }));
  }
}
