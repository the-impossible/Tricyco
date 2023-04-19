import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/services/database.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String randomId = Uuid().v4();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? userType;

  Future<void> createAccount() async {
    try {
      QuerySnapshot snaps = await FirebaseFirestore.instance
          .collection('users')
          .where("phone", isEqualTo: phoneController.text)
          .get();

      if (snaps.docs.length != 1) {
        var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        // Create a new user
        await DatabaseService(uid: user.user!.uid).createUserData(
            nameController.text.trim(),
            emailController.text.trim(),
            phoneController.text.trim(),
            userType!);

        if (userType! == "Driver") {
          await FirebaseFirestore.instance
              .collection("tricycleData")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set(
            {
              "plateNumber": "",
              "color": "Yellow",
              "pass": 4,
              "status": true,
            },
          );
        }

        nameController.clear();
        phoneController.clear();
        emailController.clear();
        passwordController.clear();

        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar("Account Created Successfully", true));
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Phone number exists!", false));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar(e.message.toString(), false));
    }
  }
}
