import 'dart:async';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/components/animated_button_widget.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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

  var formKey = GlobalKey<FormState>();
  String? name;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
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
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.asset('assets/images/quiz.json'),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Please Enter Full Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PlaypenSans',
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return '       Name mustn\'t be Empty';
                    }
                    return null;
                  },
                  onChanged: (v) {
                    name = v;
                  },
                  onFieldSubmitted: (v) {
                    name = v;
                    if (formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, QuizScreen.id,
                          arguments: name);
                    }
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'PlaypenSans',
                    fontSize: 15,
                  ),
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.user,
                      color: Colors.white,
                    ),
                    hintText: 'Enter Full name',
                    errorStyle: TextStyle(
                      fontFamily: 'PlaypenSans',
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PlaypenSans',
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: AnimatedButtonWidget(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          QuizScreen.id,
                          (route) => false,
                          arguments: name!,
                        );
                      }
                    },
                    text: 'Ready to Start Quiz',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
