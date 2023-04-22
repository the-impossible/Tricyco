import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/services/database.dart';

class StartRideController extends GetxController {
  DatabaseService databaseService = Get.put(DatabaseService());

  Future<void> startRide(String driverID) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    bool message =
        await databaseService.startRide(FirebaseAuth.instance.currentUser!.uid);

    if (message) {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Your ride just began", true));
    } else {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Something went wrong", false));
    }
  }

  Future<void> endRide(String driverID) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    bool message = await databaseService
        .completeRide(FirebaseAuth.instance.currentUser!.uid);

    if (message) {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Your ride has ended", true));
    } else {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Something went wrong", false));
    }
  }
}
