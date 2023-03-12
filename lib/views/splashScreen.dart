import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tricycle/utils/constant.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.primaryColor,
        body: Column(
          children: [
            Image.asset("assets/tricycle.png"),
            const Text(
              'Tricyco',
              style: TextStyle(
                color: Constants.tertiaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
