import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/score_screen.dart';
import 'package:quiz_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      initialRoute: SplachScreen.id,
      routes: {
        SplachScreen.id: (context) => const SplachScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        QuizScreen.id: (context) => const QuizScreen(),
        ScoreScreen.id: (context) => const ScoreScreen(),
      },
    );
  }
}
