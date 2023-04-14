import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/services/database.dart';

class DecideRouteController extends GetxController {
  String from = "";
  String to = "";

  DatabaseService databaseService = Get.put(DatabaseService());

  Future<void> bookTricycle() async {
    if (from != '' && to != '') {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Book ride
      String docRef = await databaseService.bookTricycle(
          Get.parameters['userID'], Get.parameters['driverID'], to, from);
      navigator!.pop(Get.context!);

      if (docRef != "") {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Tricycle has been Booked!", true));
        var data = {'docRef': docRef};

        Get.offNamed(Routes.bookingStatus, parameters: data);
      } else {
        navigator!.pop(Get.context!);
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Something went wrong!", false));
      }
    }else{
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(delegatedSnackBar("Something went wrong!", false));
    }
  }
}
