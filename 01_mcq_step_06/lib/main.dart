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
  //Paste the step 07 code below

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
                    child: Text(
                  "Question",
                  textScaleFactor: 1.5,
                ))),
            Expanded(
                child: Container(
              color: Colors.amber,
              width: double.infinity,
              //Paste the step 05 code below
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print("Answer 0 clicked");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: const Text(
                                'Answer 0',
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print("Answer 1 clicked");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: const Text(
                                'Answer 1',
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print("Answer 2 clicked");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: const Text(
                                'Answer 2',
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print("Answer 3 clicked");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: const Text(
                                'Answer 3',
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
            Container(
                height: 80,
                width: double.infinity,
                color: Colors.greenAccent,
                child: ElevatedButton(
                  onPressed: () {
                    print("Button clicked");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                  ),
                  child: const Text(
                    'Check',
                    textScaleFactor: 1.5,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
