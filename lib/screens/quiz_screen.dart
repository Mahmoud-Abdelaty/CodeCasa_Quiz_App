import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/components/question_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  static String id = 'QuizScreen';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Color> colorList = [
    const Color(0xff171B70),
    const Color(0xff410D75),
    const Color(0xff032340),
    const Color(0xff050340),
    const Color(0xff2C0340),
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = const Color.fromARGB(255, 6, 31, 59);
  Color topColor = const Color.fromARGB(255, 96, 18, 173);
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(microseconds: 500),
      () {
        setState(
          () {
            bottomColor = const Color(0xff33267C);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          onEnd: () {
            setState(
              () {
                index = index + 1;
                bottomColor = colorList[index % colorList.length];
                topColor = colorList[(index + 1) % colorList.length];
              },
            );
          },
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: [bottomColor, topColor],
            ),
          ),
          child: const QuestionWidget(),
        ),
      ),
    );
  }
}
