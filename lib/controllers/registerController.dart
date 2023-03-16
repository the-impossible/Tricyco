import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/views/wrapper.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? userType;

  Future<void> createAccount() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      final docUser = FirebaseFirestore.instance.collection("users").doc();

      print("OBJECT: $user");
      print("OBJECT: ${user.user!.uid}");

      final json = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'userType': userType,
        'user_id': user.user!.uid,
      };

      await docUser.set(json);

      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          delegatedSnackBar("Account Created Successfully", true));
    } on FirebaseAuthException catch (e) {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar(e.message.toString(), false));
    }
  }
}
