import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:pac_ninja/controllers/game_provider.dart';
import 'package:pac_ninja/enemy/skull_enemy.dart';
import 'package:pac_ninja/items/items.dart';
import 'package:pac_ninja/player/ninja_player.dart';
import 'package:pac_ninja/ui/game_ui.dart';
import 'package:provider/provider.dart';

class MainGame extends StatefulWidget {
  const MainGame({Key? key}) : super(key: key);

  @override
  State<MainGame> createState() => _MainGameState();
}

class _MainGameState extends State<MainGame> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GameState(),
      child: BonfireTiledWidget(
        // collisionAreaColor: Colors.blue,
        // showCollisionArea: true,
        player: NinjaPlayer(),
        overlayBuilderMap: {
          'ui': ((context, game) => GameUI(
                game: game,
              ))
        },
        initialActiveOverlays: const ["ui"],
        components: [
          // SkullEnemy(position: Vector2(512,256)),
          NinjaAxe(Vector2(496, 32)),
          NinjaAxe(Vector2(710, 292)),
          NinjaAxe(Vector2(38, 520)),
        ],
        joystick: Joystick(
            keyboardConfig: KeyboardConfig(
                keyboardDirectionalType:
                    KeyboardDirectionalType.wasdAndArrows)),
        map: TiledWorldMap('maps/myMap.json',
            forceTileSize: const Size(32, 32),
            objectsBuilder: {
              'sushi': (props) => Sushi(props.position),
              'skull': (props) => SkullEnemy(position: props.position),
            }),
        cameraConfig: CameraConfig(
          moveOnlyMapArea: true,
        ),
      ),
    );
  }
}
