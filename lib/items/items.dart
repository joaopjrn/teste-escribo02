import 'dart:async';

import 'package:bonfire/bonfire.dart';

class NinjaAxe extends GameDecoration with ObjectCollision {
  NinjaAxe(Vector2 pos):super.withSprite(
    sprite: Items.axe, position: pos, size: Vector2(50,50)
  ){
    setupCollision(CollisionConfig(
      collisions: [
      CollisionArea.circle(radius: 10, align: Vector2(0,0))
    ]));
  }
}

class Sushi extends GameDecoration with ObjectCollision {
  Sushi(Vector2 pos):super.withSprite(
    sprite: Items.sushi, position: Vector2(pos.x+8, pos.y+8), size: Vector2(32,32)
  ){
    setupCollision(CollisionConfig(
      collisions: [
      CollisionArea.circle(radius: 8, align: Vector2(0,0))
    ]));
  }
}

class Items {
  static Future<Sprite> get axe => Sprite.load('tilesets/NinjaAdventure/Items/Weapons/Axe/Sprite.png', srcPosition: Vector2(0,0), srcSize: Vector2(32,32));
  static Future<Sprite> get sushi => Sprite.load('tilesets/NinjaAdventure/Items/Food/Sushi.png', srcPosition: Vector2(0,0), srcSize: Vector2(32,32));
}