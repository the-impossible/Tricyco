import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/services/database.dart';

class ApproveBookingController extends GetxController {
  DatabaseService databaseService = Get.put(DatabaseService());

  Future<void> approveStatus(String bookingID) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    int? pass = await databaseService
        .getPassNumber(FirebaseAuth.instance.currentUser!.uid);

    bool seatSuccess = await databaseService.updateSeatNo(
        FirebaseAuth.instance.currentUser!.uid, pass! - 1);

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
  }
}
