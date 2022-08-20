import 'dart:async' as Timer;

import 'package:bonfire/bonfire.dart';
import 'package:pac_ninja/controllers/player_controller.dart';
import 'package:pac_ninja/items/items.dart';
import 'package:pac_ninja/player/ninja_sprite.dart';

class NinjaPlayer extends SimplePlayer
    with ObjectCollision, UseStateController<PlayerController> {
  final _colConfig = CollisionConfig(collisions: [
    CollisionArea.rectangle(size: Vector2(20, 20), align: Vector2(6, 6))
  ]);

  CollisionConfig get colConfig => _colConfig;

  NinjaPlayer()
      : super(
            position: Vector2(32, 32),
            size: Vector2(32, 32),
            initDirection: Direction.down,
            speed: 150,
            animation: SimpleDirectionAnimation(
              idleRight: NinjaSprite.idleRight,
              idleLeft: NinjaSprite.idleLeft,
              idleDown: NinjaSprite.idleDown,
              idleUp: NinjaSprite.idleUp,
              runRight: NinjaSprite.runRight,
              runLeft: NinjaSprite.runLeft,
              runDown: NinjaSprite.runDown,
              runUp: NinjaSprite.runUp,
            )) {
    setupCollision(colConfig);
    
  }
  int points = 0;
  bool isHunting() {
    return controller.isHunting;
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    if (component is NinjaAxe) {
      controller.handleAxeCollision(component);
      return false;
    }
    if (component is Sushi) {
      controller.handleSushiCollision(component, gameRef.player);
      return false;
    }
    return super.onCollision(component, active);
  }
}
