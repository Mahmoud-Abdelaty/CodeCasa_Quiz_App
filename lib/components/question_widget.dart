import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/components/animated_button_widget.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/screens/score_screen.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key}) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
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

  int score = 0;
  bool onPressed = false;
  PageController? controller;
  String buttonText = "Next Question";
  bool answered = false;
  String? wrong;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    Timer(
      const Duration(microseconds: 250),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String? name = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      body: AnimatedContainer(
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
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: PageView.builder(
            controller: controller,
            onPageChanged: (page) {
              if (page == questionsList.length - 1) {
                setState(() {
                  buttonText = 'Show Score';
                });
              }
              setState(() {
                answered = false;
              });
            },
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: height / width + 20,
                        top: height / width + 20,
                      ),
                      child: Text(
                        'Hello , $name 🙋🏻‍♂️',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 198, 255, 9),
                          fontFamily: 'PlaypenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: height / width + 22,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height / width + 17,
                        bottom: height / width + 17,
                      ),
                      child: Center(
                        child: Text(
                          'Question  ${index + 1} / 12',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 198, 255, 9),
                            fontFamily: 'PlaypenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: height / width + 23,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      height: questionsList[index].choices.length != 2
                          ? height - 240
                          : height / width + 460,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(height / width + 18),
                            height: height / width + 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.indigo[700],
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(height / width + 10),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '${index + 1}. ${questionsList[index].question}',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontFamily: 'PlaypenSans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: height / width + 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          wrong == null
                              ? const SizedBox()
                              : Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: height / width + 3,
                                    ),
                                    child: Text(
                                      '$wrong',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 7, 7),
                                        fontFamily: 'PlaypenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: height / width + 15,
                                      ),
                                    ),
                                  ),
                                ),
                          for (int i = 0;
                              i < questionsList[index].choices.length;
                              i++)
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: height / width + 10,
                                horizontal: height / width + 25,
                              ),
                              height: height / width + 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                border: Border.all(
                                  color: Colors.white,
                                  width: height / width + .9,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.indigo,
                                colorBrightness: Brightness.dark,
                                disabledColor:
                                    questionsList[index].choices[i] ==
                                            questionsList[index].answer
                                        ? Colors.green[900]
                                        : Colors.red[900],
                                onPressed: !answered
                                    ? () {
                                        if (questionsList[index].choices[i] ==
                                            questionsList[index].answer) {
                                          score++;
                                        }
                                        setState(() {
                                          onPressed = true;
                                          wrong = null;
                                          answered = true;
                                        });
                                      }
                                    : null,
                                child: Text(
                                  questionsList[index].choices[i],
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontFamily: 'PlaypenSans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: height / width + 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: height / width + 10,
                            ),
                            child: Center(
                              child: AnimatedButtonWidget(
                                onPressed: () {
                                  if (controller!.page ==
                                      questionsList.length - 1) {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      ScoreScreen.id,
                                      (route) => false,
                                      arguments: {
                                        'name': name,
                                        'score': score,
                                      },
                                    );
                                  } else if (onPressed != false) {
                                    controller!.nextPage(
                                      duration: const Duration(
                                        milliseconds: 2,
                                      ),
                                      curve: Curves.easeInOutCirc,
                                    );

                                    setState(() {
                                      onPressed = false;
                                      wrong = null;
                                    });
                                  } else if (onPressed != true) {
                                    setState(() {
                                      wrong = 'Please Choose Answer';
                                    });
                                  }
                                },
                                text: buttonText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: questionsList.length,
          ),
        ),
      ),
    );
  }
}
