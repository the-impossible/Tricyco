import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedForm.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/utils/constant.dart';

import '../routes/routes.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
                    padding: const EdgeInsets.only(top: 15),
                    child: DelegatedText(
                      text: 'Sign in',
                      fontSize: 23,
                      color: Constants.primaryColor,
                      fontName: 'InterBold',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: SvgPicture.asset(
                      "assets/sign_In.svg",
                      width: 200,
                      height: 150,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: DelegatedText(
                            text: 'Forget password?',
                            fontSize: 15,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Get.offNamed(Routes.signUp),
                      style: ElevatedButton.styleFrom(
                        primary: Constants.primaryColor,
                      ),
                      child: DelegatedText(
                        fontSize: 15,
                        text: 'Sign In',
                        color: Constants.secondaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DelegatedText(
                          text: "Don't have an account?",
                          fontSize: 15,
                          color: Constants.tertiaryColor,
                        ),
                        TextButton(
                          onPressed: () => Get.offNamed(Routes.signUp),
                          child: DelegatedText(
                            text: "Sign up?",
                            fontSize: 15,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
