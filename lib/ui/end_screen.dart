import 'package:flutter/cupertino.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Fim de Jogo!',
      style: TextStyle(
        decoration: TextDecoration.none
      ),),
    );
  }
}