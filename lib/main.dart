import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // Explicit
  Widget nameApp = Text('Ung Food');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ung Food',
      home: nameApp,
    );
  }
}
