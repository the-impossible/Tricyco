import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';

class LogoutController extends GetxController {
  Future signOut() async {
    FirebaseAuth.instance.signOut();
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(delegatedSnackBar("You are now logout", true));

    navigator!.pop(Get.context!);
  }
}
