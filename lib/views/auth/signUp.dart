import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedForm.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/controllers/registerController.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/utils/constant.dart';
import 'package:tricycle/utils/form_validators.dart';

class SignUp extends StatefulWidget {
  final Function onClicked;

  const SignUp({required this.onClicked, super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegisterController registerController = Get.put(RegisterController());

  final _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 20),
                      child: DelegatedText(
                        text: 'Create new account',
                        fontSize: 23,
                        color: Constants.primaryColor,
                        fontName: 'InterBold',
                      ),
                    ),
                    delegatedForm(
                      fieldName: 'Email',
                      icon: Icons.mail_rounded,
                      hintText: 'Enter your email',
                      formController: registerController.emailController,
                      validator: FormValidator.validateEmail,
                    ),
                    delegatedForm(
                      fieldName: 'Password',
                      icon: Icons.lock,
                      hintText: 'Enter your password',
                      formController: registerController.passwordController,
                      validator: FormValidator.validatePassword,
                    ),
                    delegatedForm(
                      fieldName: 'Full name',
                      icon: Icons.person,
                      hintText: 'Enter your full name',
                      formController: registerController.nameController,
                      validator: FormValidator.validateName,
                    ),
                    delegatedForm(
                      fieldName: 'Mobile number',
                      icon: Icons.call,
                      hintText: 'Enter your number',
                      formController: registerController.phoneController,
                      validator: FormValidator.validatePhone,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: MoodDropdownMenu(),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            registerController.createAccount();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Constants.primaryColor,
                        ),
                        child: DelegatedText(
                          fontSize: 15,
                          text: 'Sign Up',
                          color: Constants.secondaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DelegatedText(
                            text: "Already have an account?",
                            fontSize: 15,
                            color: Constants.tertiaryColor,
                          ),
                          TextButton(
                            onPressed: () {
                              widget.onClicked();
                            },
                            child: DelegatedText(
                              text: "Sign in",
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
      ),
    );
  }
}

class MoodDropdownMenu extends StatefulWidget {
  const MoodDropdownMenu({super.key});

  @override
  State<MoodDropdownMenu> createState() => _MoodDropdownMenuState();
}

List<String> userTypes = ['Users', 'Driver'];

class _MoodDropdownMenuState extends State<MoodDropdownMenu> {
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    String? userType;

    return DropdownButtonFormField<String>(
      validator: FormValidator.validateUserType,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Constants.primaryColor,
          ),
        ),
      ),
      value: userType,
      hint: const Text('Select user type'),
      onChanged: (String? newValue) {
        setState(() {
          userType = newValue!;
          registerController.userType = newValue;
        });
      },
      items: userTypes
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
    );
  }
}
