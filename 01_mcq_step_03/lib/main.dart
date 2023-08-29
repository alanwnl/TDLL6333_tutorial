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
      home: const MCQScreen(),
    );
  }
}

class MCQScreen extends StatefulWidget {
  const MCQScreen({super.key});

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MCQ"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: 120,
                width: double.infinity,
                color: Colors.greenAccent,
                child: const Center(
                    child: Text("Question",textScaleFactor: 1.5,)
                )
            ),
            Expanded(child: Container(
              color: Colors.amber,
              width: double.infinity,
              //Paste the step 05 code below
            )),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.greenAccent,
              //Paste the step 04 code below
            )
          ],
        ),
      ),
    );
  }
}

