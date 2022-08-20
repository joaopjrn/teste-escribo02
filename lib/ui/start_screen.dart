import 'package:flutter/material.dart';
import 'package:pac_ninja/widgets/main_game.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset('assets/images/logo.png'),
      SizedBox(height: 20,),
      ElevatedButton(
          child: const Text('Iniciar', style: TextStyle(
            color: Colors.white,
            fontSize: 30
          )),
          style: ElevatedButton.styleFrom(
            primary: Colors.green[700],
            padding: EdgeInsets.all(15)
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) {
                  return const MainGame();
                }));
          })
    ]));
  }
}
