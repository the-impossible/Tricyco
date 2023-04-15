import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/services/database.dart';

class WalletController extends GetxController {
  TextEditingController amountController = TextEditingController();
  DatabaseService databaseService = Get.put(DatabaseService());

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> setBalance() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    // Update tricycle data
    bool success = await databaseService.setBalance(FirebaseAuth.instance.currentUser!.uid, amountController.text);
    if (success) {
      amountController.clear();

      navigator!.pop(Get.context!);

      ScaffoldMessenger.of(Get.context!).showSnackBar(
          delegatedSnackBar("Wallet has been Updated", true));
    } else {
      navigator!.pop(Get.context!);

      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Something went wrong!", false));
    }
  }
}
