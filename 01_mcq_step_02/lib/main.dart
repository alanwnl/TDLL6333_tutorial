import 'package:flutter/material.dart';

void main() => runApp(MCQApp());

class MCQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCQ Question App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MCQScreen(),
    );
  }
}

//Paste the step 02 code below
class MCQScreen extends StatefulWidget {
  const MCQScreen({super.key});

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

//Replace following code in step 3
class _MCQScreenState extends State<MCQScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
