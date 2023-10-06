import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';
import 'mcq_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MCQApp(),
    ),
  );
}

class MCQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCQ Question App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MCQScreen(),
    );
  }
}
