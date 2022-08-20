import 'dart:async' as Timer;
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:pac_ninja/controllers/game_provider.dart';
import 'package:pac_ninja/enemy/skull_sprite.dart';
import 'package:pac_ninja/items/items.dart';
import 'package:pac_ninja/player/ninja_player.dart';
import 'package:pac_ninja/ui/end_screen.dart';
import 'package:provider/provider.dart';

const tileSize = 32;

class SkullEnemy extends SimpleEnemy
    with ObjectCollision, MoveToPositionAlongThePath, AutomaticRandomMovement {
  final points = [
    Vector2(32, 32),
    Vector2(960, 32),
    Vector2(960, 512),
    Vector2(32, 512),
    Vector2(224, 160),
    Vector2(640, 384),
    Vector2(496, 32)
  ];

  bool runningAway = false;

  CollisionConfig colConfig = CollisionConfig(collisions: [
    CollisionArea.rectangle(size: Vector2(8, 8), align: Vector2(10, 10)),
  ]);

  dynamic _getPlayer() {
    var p;
    var pList = gameRef.componentsByType<NinjaPlayer>().toList();
    if (pList.isNotEmpty) p = pList[0];
    return p;
  }

  SkullEnemy({required Vector2 position})
      : super(
            position: position,
            size: Vector2(32, 32),
            speed: 100,
            animation: SimpleDirectionAnimation(
              idleRight: SkullSprite.idleRight,
              idleLeft: SkullSprite.idleLeft,
              idleDown: SkullSprite.idleDown,
              idleUp: SkullSprite.idleUp,
              runRight: SkullSprite.runRight,
              runLeft: SkullSprite.runLeft,
              runDown: SkullSprite.runDown,
              runUp: SkullSprite.runUp,
            )) {
    setupCollision(colConfig);
    setupMoveToPositionAlongThePath(pathLineColor: Colors.transparent);

    List<Vector2> chain = [...points]..shuffle();

    Timer.Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isMovingAlongThePath) {
        if (chain.isEmpty) {
          chain = [...points]..shuffle();
        }

        moveToPositionAlongThePath(chain.removeAt(0), ignoreCollisions: [
          runningAway ? null : _getPlayer(),
          ...gameRef.componentsByType<NinjaAxe>().toList(),
          ...gameRef.componentsByType<Sushi>().toList(),
          this
        ]);
      }
    });
  }

  bool sawOnce = false;
  bool goingBase = false;
  double tt = 0;

  @override
  void update(double dt) {
    var p = _getPlayer();

    if (p != null && (p as NinjaPlayer).isHunting()) {
      runningAway = true;
    } else {
      runningAway = false;
    }
    tt += dt;
    seePlayer(
        observed: ((p0) {
          if (!(p0 as NinjaPlayer).isDead && !goingBase && !p0.isHunting()) {
            if (tt > 3) {
              tt = 0;
              double x = (p0.position.x / 32).roundToDouble() * 32;
              double y = (p0.position.y / 32).roundToDouble() * 32;
              Vector2 pos = Vector2(x, y);

              moveToPositionAlongThePath(pos, ignoreCollisions: [
                runningAway ? null : p0,
                ...gameRef.componentsByType<NinjaAxe>().toList(),
                ...gameRef.componentsByType<Sushi>().toList(),
              ]);
            }
          }
        }),
        radiusVision: 300);
    super.update(dt);
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    if(component is Sushi){
      return false;
    }
    if (component is NinjaAxe) {
      return false;
    }
    if (component is SkullEnemy) {
      return false;
    }
    if (component is NinjaPlayer) {
      if(!component.isDead){

      if (!component.isHunting() && !goingBase) {
        component.die();

        component.removeFromParent();
        Navigator.of(gameRef.context)
    .pushReplacement(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) {
          return const EndScreen();
        }));
      } else {
        if(!goingBase){
          Provider.of<GameState>(gameRef.context, listen: false).updatePoints(10, gameRef);
        }
        goingBase = true;
        speed = 300;
        if (isMovingAlongThePath) {
          stopMoveAlongThePath();
        }
        moveToPositionAlongThePath(Vector2(512, 256), ignoreCollisions: [
          ...gameRef.componentsByType<SkullEnemy>().toList(),
          ...gameRef.componentsByType<NinjaPlayer>().toList(),
          ...gameRef.componentsByType<Sushi>().toList(),
        ]);
      }
      }
      // return false;
    }
    return super.onCollision(component, active);
  }

  @override
  void onMove(double speed, Direction direction, double angle) {
    int x = position.x.toInt();
    int y = position.y.toInt();
    if ((x >= 415 && x <= 580) && (y >= 193 && y <= 354)) {
      //inside monster base
      if (goingBase) {
        this.speed = 100;
        goingBase = false;
      }
    }
    super.onMove(speed, direction, angle);
  }
}
