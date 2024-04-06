import 'package:flutter/material.dart';

import 'package:example/src/ui/crud_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CRUDScreen(),
    );
  }
}