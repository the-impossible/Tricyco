import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/views/auth/authenticate.dart';
import 'package:tricycle/views/auth/signIn.dart';
import 'package:tricycle/views/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: DelegatedText(
              text: 'Something went wrong!',
              fontSize: 20,
            ),
          );
        } else if (snapshot.hasData) {
          print('DATA DEY');
          return const HomePage();
        } else {
          print('DATA NO DEY');
          return const Authenticate();
        }
      },
    );
  }
}
