import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/models/tricycle_data.dart';
import 'package:tricycle/models/user_data.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/services/database.dart';

class TricycleDetailsController extends GetxController {
  TricycleData? tricycleData;
  UserData? driverData;

  String driverID = "";

  DatabaseService databaseService = Get.put(DatabaseService());

  Future<void> getTricycleDetails() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    // Update tricycle data
    tricycleData = await databaseService.getTricycleData(driverID);
    driverData = await databaseService.getUser(driverID, 'Driver');
    if (tricycleData != null && driverData != null) {
      navigator!.pop(Get.context!);
      Get.toNamed(Routes.kekeDetails);
    } else {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Something went wrong!", false));
    }
  }
}
