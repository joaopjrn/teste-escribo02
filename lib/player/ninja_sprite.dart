import 'package:bonfire/bonfire.dart';

const double spriteSize = 16;

class NinjaSprite {
  static Future<SpriteAnimation> _sequenceImage(
      String fileName, double x, double y) {
    return SpriteAnimation.load(
        'tilesets/NinjaAdventure/Actor/Characters/BlueNinja/$fileName',
        SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.15,
            textureSize: Vector2(16, 16),
            texturePosition: Vector2(x, y)
            )
      );
  }

static Future<SpriteAnimation> _static(String fileName, double x, double y) {
    return SpriteAnimation.load(
      'tilesets/NinjaAdventure/Actor/Characters/BlueNinja/$fileName',
      SpriteAnimationData.sequenced(
        amount: 1, 
        stepTime: 0.15, 
        textureSize: Vector2(16,16),
        texturePosition: Vector2(x,y)
      ),
    );
       // srcPosition: Vector2(x, y), srcSize: Vector2(16, 16));
  }

  static Future<SpriteAnimation> get idleLeft => _static('Idle.png', spriteSize*2, 0);
  static Future<SpriteAnimation> get idleRight => _static('Idle.png', spriteSize*3,0);
  static Future<SpriteAnimation> get idleUp => _static('Idle.png', spriteSize*1,0);
  static Future<SpriteAnimation> get idleDown => _static('Idle.png', spriteSize*0,0);

  static Future<SpriteAnimation> get runLeft => _sequenceImage('Walk.png', 0,spriteSize*2);
  static Future<SpriteAnimation> get runRight => _sequenceImage('Walk.png', 0,spriteSize*3);
  static Future<SpriteAnimation> get runUp => _sequenceImage('Walk.png', 0,spriteSize*1);
  static Future<SpriteAnimation> get runDown => _sequenceImage('Walk.png', 0,spriteSize*0);
}