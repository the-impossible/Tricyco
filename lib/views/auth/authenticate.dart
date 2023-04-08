import 'package:flutter/material.dart';
import 'package:tricycle/views/auth/signIn.dart';
import 'package:tricycle/views/auth/signUp.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isLogin = true;

  void toggle() {
    setState(() => isLogin = !isLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return SignIn(onClicked: toggle);
    } else {
      return SignUp(onClicked: toggle);
    }
  }
}
