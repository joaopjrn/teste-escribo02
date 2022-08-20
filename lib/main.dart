import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:pac_ninja/controllers/player_controller.dart';
import 'package:pac_ninja/ui/start_screen.dart';

void main() {
  BonfireInjector.instance.put((i) => PlayerController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartScreen(),
    );
  }
}
