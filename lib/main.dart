import 'package:flutter/material.dart';
import 'package:quizzler_project/quizLogic.dart';
import 'package:quizzler_project/question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizLogic quizLogic = QuizLogic();

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> icons = [];
  Question pickedQuestion = quizLogic.pickUpQuestion();

  List<Icon> answerChecker(bool userAnswer, bool questionAnswer) {
    Icon iconUnit = userAnswer == questionAnswer
        ? const Icon(Icons.check, color: Colors.green)
        : const Icon(Icons.close, color: Colors.red);
    icons.add(iconUnit);
    return icons;
  }

  void isFinishedGame() {
    setState(() {
      if (quizLogic.getListLength() == 0) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          buttons: <DialogButton>[
            DialogButton(
              child: const Text(
                'RESTART',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                restart();
                icons = [];
                pickAQuestion();
              },
            ),
          ],
        ).show();
      }
    });
  }

  void pickAQuestion() {
    setState(() {
      pickedQuestion = quizLogic.pickUpQuestion();
    });
  }

  void restart() {
    setState(() {
      quizLogic = QuizLogic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              pickedQuestion.questionText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green,
            child: TextButton(
              onPressed: () {
                setState(() {
                  answerChecker(true, pickedQuestion.questionAnswer);
                  isFinishedGame();
                  pickAQuestion();
                });
              },
              child: const Text(
                "True",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(16),
            color: Colors.red,
            child: TextButton(
              onPressed: () {
                setState(() {
                  answerChecker(false, pickedQuestion.questionAnswer);
                  isFinishedGame();
                  pickAQuestion();
                });
              },
              child: const Text(
                "False",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: icons,
        ),
      ],
    );
  }
}
