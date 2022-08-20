import 'package:bonfire/base/bonfire_game.dart';
import 'package:flutter/material.dart';
import 'package:pac_ninja/controllers/game_provider.dart';
import 'package:provider/provider.dart';

class GameUI extends StatefulWidget {
  final BonfireGame game;
  const GameUI({Key? key, required this.game}) : super(key: key);

  @override
  State<GameUI> createState() => _GameUIState();
}

class _GameUIState extends State<GameUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final points = Provider.of<GameState>(context).points;
    var txtPontos = Text('Pontos: $points', style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 30));
    return Row(children: [
      Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.black.withAlpha(150),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: txtPontos,
      ),

    ]);
  }
}