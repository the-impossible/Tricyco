import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/services/database.dart';

class TricycleDataController extends GetxController {
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController tricycleColorController = TextEditingController();

  DatabaseService databaseService = Get.put(DatabaseService());

  @override
  void dispose() {
    plateNumberController.dispose();
    tricycleColorController.dispose();
    super.dispose();
  }

  Future<void> updateTricycle() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    // Update tricycle data
    bool success = await databaseService.updateTricycleData(
        plateNumberController.text, tricycleColorController.text);
    if (success) {
      plateNumberController.clear();
      tricycleColorController.clear();

      navigator!.pop(Get.context!);

      ScaffoldMessenger.of(Get.context!).showSnackBar(
          delegatedSnackBar("Tricycle Data Updated Successfully", true));
    } else {
      navigator!.pop(Get.context!);

      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Something went wrong!", false));
    }
  }
}
