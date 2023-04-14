import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/services/database.dart';
import '../models/bookingList_data.dart';

class BookingStatusController extends GetxController {
  DatabaseService databaseService = Get.put(DatabaseService());
  BookingList? bookingList;

  Future<void> getBookingStatus() async {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Book ride
      // bookingList =
      //     await databaseService.getBookingStatus(Get.parameters['docRef']);
      navigator!.pop(Get.context!);

        Get.offNamed(Routes.bookingStatus);
      if (bookingList != null) {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Tricycle has been Booked!", true));
      }
     else {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Something went wrong!", false));
    }
  }
}
