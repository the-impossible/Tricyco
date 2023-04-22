import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/services/database.dart';

class DriverWalletController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  DatabaseService databaseService = Get.put(DatabaseService());

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> disburseFunds() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    //Verify if user has enough balance booking
    bool fundIsEnough = await databaseService.hasBalance(
        FirebaseAuth.instance.currentUser!.uid,
        double.parse(amountController.text));

    if (fundIsEnough) {
      bool success = await databaseService.disburseFunds(
          FirebaseAuth.instance.currentUser!.uid, amountController.text);

      if (success) {
        amountController.clear();
        accountController.clear();
        navigator!.pop(Get.context!);

        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Credited successfully", true));
      } else {
        navigator!.pop(Get.context!);
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Something went wrong!", false));
      }
    } else {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          delegatedSnackBar("Amount higher than earnings!", false));
    }
  }
}
