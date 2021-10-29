import 'package:flutter/material.dart';

class PlayerHome extends StatefulWidget {
  const PlayerHome({Key? key}) : super(key: key);

  @override
  _PlayerHomeState createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('player home')));
  }
}
