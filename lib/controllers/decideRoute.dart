import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/services/database.dart';

class DecideRouteController extends GetxController {
  String from = "";
  String to = "";
  int seats = 1;

  DatabaseService databaseService = Get.put(DatabaseService());

  Future<void> bookTricycle() async {
    if (from != '' && to != '') {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      //Verify if user has pending booking
      QuerySnapshot snaps = await databaseService
          .getUserPendingBookings(Get.parameters['userID']);

      print("length: ${snaps.docs.length}");

      if (snaps.docs.isEmpty) {
        // Get Pass number
        int? pass =
            await databaseService.getPassNumber(Get.parameters['driverID']!);

        if (seats <= pass!) {
          // Book ride
          String docRef = await databaseService.bookTricycle(
              Get.parameters['userID'],
              Get.parameters['driverID'],
              to,
              from,
              seats);
          navigator!.pop(Get.context!);

          if (docRef != "") {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
                delegatedSnackBar("Tricycle has been Booked!", true));
            var data = {'docRef': docRef};

            Get.offNamed(Routes.bookingStatus, parameters: data);
          } else {
            navigator!.pop(Get.context!);
            ScaffoldMessenger.of(Get.context!).showSnackBar(
                delegatedSnackBar("Something went wrong!", false));
          }
        } else {
          navigator!.pop(Get.context!);
          ScaffoldMessenger.of(Get.context!).showSnackBar(
              delegatedSnackBar("Available seat is $pass!", false));
        }
      } else {
        navigator!.pop(Get.context!);
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("You have pending ride!", false));
      }
    } else {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Unable to decide routes!", false));
    }
  }
}
