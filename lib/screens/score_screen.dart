import 'package:lottie/lottie.dart';
import 'package:quiz_app/components/animated_button_widget.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  static String id = 'ScoreScreen';

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
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
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
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
          child: arg['score'] >= 6
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/images/celebration.json'),
                    Text(
                      'Congratulations .. ${arg['name']}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 198, 255, 9),
                        fontFamily: 'PlaypenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your Result : ${arg['score'].toString()} / 12',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 198, 255, 9),
                        fontFamily: 'PlaypenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Lottie.asset(
                      'assets/images/congratulations.json',
                      width: 250,
                    ),
                    AnimatedButtonWidget(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          QuizScreen.id,
                          (route) => false,
                          arguments: arg['name'],
                        );
                        arg['score'] = 0;
                      },
                      text: 'Restart Quiz',
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/images/sorry.json', width: 200),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Sorry .. ${arg['name']}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 198, 255, 9),
                        fontFamily: 'PlaypenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your Result : ${arg['score'].toString()} / 12',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 198, 255, 9),
                        fontFamily: 'PlaypenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Please Study Hard 👌',
                      style: TextStyle(
                        color: Color.fromARGB(255, 198, 255, 9),
                        fontFamily: 'PlaypenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AnimatedButtonWidget(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          QuizScreen.id,
                          (route) => false,
                          arguments: arg['name'],
                        );
                        arg['score'] = 0;
                      },
                      text: 'Restart Quiz',
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
