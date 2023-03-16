import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/utils/constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: DelegatedText(
                text: '${user.uid}',
                fontSize: 20,
              ),
            ),
            ElevatedButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: DelegatedText(
                text: 'Sign out',
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
