import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

class AnimatedButtonWidget extends StatelessWidget {
  const AnimatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedButton(
      width: 230,
      color: const Color.fromARGB(255, 66, 75, 245),
      onPressed: () {
        onPressed();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      enabled: true,
      shadowDegree: ShadowDegree.light,
      child: Text(
        text,
        style: TextStyle(
          fontSize: height / width + 17,
          color: Colors.white,
          fontFamily: 'PlaypenSans',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
