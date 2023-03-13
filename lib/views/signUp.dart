import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tricycle/components/delegatedForm.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/utils/constant.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.secondaryColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 40),
                    child: DelegatedText(
                      text: 'Create new account',
                      fontSize: 23,
                      color: Constants.primaryColor,
                      fontName: 'InterBold',
                    ),
                  ),
                  const delegatedForm(
                    fieldName: 'Email',
                    icon: Icons.mail_rounded,
                    hintText: 'Enter your email',
                  ),
                  const delegatedForm(
                    fieldName: 'Password',
                    icon: Icons.lock,
                    hintText: 'Enter your password',
                  ),
                  const delegatedForm(
                    fieldName: 'Full name',
                    icon: Icons.person,
                    hintText: 'Enter your full name',
                  ),
                  const delegatedForm(
                    fieldName: 'Mobile number',
                    icon: Icons.call,
                    hintText: 'Enter your number',
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Constants.primaryColor,
                      ),
                      child: DelegatedText(
                        fontSize: 15,
                        text: 'Sign In',
                        color: Constants.secondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
