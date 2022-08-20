import 'dart:async';
import 'package:bonfire/base/game_component.dart';
import 'package:bonfire/state_manager/state_controller.dart';
import 'package:pac_ninja/controllers/game_provider.dart';
import 'package:pac_ninja/player/ninja_player.dart';
import 'package:provider/provider.dart';

class PlayerController extends StateController<NinjaPlayer> {
  bool isHunting = false;

  void hunt() {
    isHunting = true;
    Timer(const Duration(seconds: 10), () {
      isHunting = false;
    });
  }

  void handleAxeCollision(GameComponent comp){
    comp.removeFromParent();
    if(!isHunting) hunt();
  }

  void handleSushiCollision(GameComponent comp, player){
    if(comp.isMounted){
    (player as NinjaPlayer).points++;
    Provider.of<GameState>(gameRef.context, listen: false).updatePoints(1, gameRef);
    }
    comp.removeFromParent();
  }

  @override
  void update(double dt, NinjaPlayer component) {
  }
}
