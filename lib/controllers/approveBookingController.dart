import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/services/database.dart';

class ApproveBookingController extends GetxController {
  DatabaseService databaseService = Get.put(DatabaseService());

  int seats = 1;

  Future<void> approveStatus(String bookingID) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    int? pass = await databaseService
        .getPassNumber(FirebaseAuth.instance.currentUser!.uid);

    int currentPass = pass! - seats;

    if (currentPass >= 0) {
      bool seatSuccess = await databaseService.updateSeatNo(
          FirebaseAuth.instance.currentUser!.uid, pass - seats);

      bool bookingSuccess = await databaseService.approveBooking(bookingID);

      if (seatSuccess && bookingSuccess) {
        navigator!.pop(Get.context!);

        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Booking Approved!", true));
      } else {
        navigator!.pop(Get.context!);
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Something went wrong!", false));
      }
    } else {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!).showSnackBar(delegatedSnackBar(
          "You can't approve ride your seats left is $pass", false));
    }
  }

  Future<void> disapproveStatus(String bookingID) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    bool bookingCanceled = await databaseService.disapproveBooking(bookingID);

    if (bookingCanceled) {
      navigator!.pop(Get.context!);

      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Booking Canceled!", true));
    } else {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Something went wrong!", false));
    }
  }
}
