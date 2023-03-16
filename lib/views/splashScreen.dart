import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tricycle/utils/constant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tricycle/views/wrapper.dart';
import '../components/delegatedText.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSplashScreen(
        splashIconSize: 300,
        centered: true,
        duration: 1000,
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        animationDuration: const Duration(
          seconds: 1,
        ),
        nextScreen: const Wrapper(),
        backgroundColor: Constants.primaryColor,
        splash: Column(
          children: [
            Image.asset(
              "assets/tricycle.png",
              width: 200,
              height: 200,
            ),
            DelegatedText(
              text: 'Tricyco',
              fontSize: 30,
              fontName: 'InterBold',
            ),
          ],
        ),
      ),
    );
  }
}
