import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tricycle/models/bookingList_data.dart';
import 'package:tricycle/models/tricycle_data.dart';
import 'package:tricycle/models/user_data.dart';
import 'package:tricycle/models/wallet_data.dart';
import 'package:flutter/services.dart';
import 'package:tricycle/utils/constant.dart';

class DatabaseService extends GetxController {
  String? uid;
  DatabaseService({this.uid});

  UserData? userData;

  WalletData? walletData;

  // collection reference
  var usersCollection = FirebaseFirestore.instance.collection("users");
  var bookingCollection = FirebaseFirestore.instance.collection("BookingList");
  var tricycleCollection =
      FirebaseFirestore.instance.collection("tricycleData");
  var walletCollection = FirebaseFirestore.instance.collection("wallet");
  var filesCollection = FirebaseStorage.instance.ref();

  //Create user
  Future createUserData(
      String name, String email, String phone, String userType) async {
    walletCollection.doc(uid).set({'balance': 0});
    await setImage(uid);
    return await usersCollection.doc(uid).set(
      {
        'name': name,
        'email': email,
        'phone': phone,
        'userType': userType,
      },
    );
  }

  //Determine userType
  Future<UserData?> getUser(String uid, String? userType) async {
    // Query database to get user type
    final snapshot = await usersCollection.doc(uid).get();
    // Return user type as string
    if (snapshot.exists) {
      if (userType != 'Driver') {
        userData = UserData.fromJson(snapshot.data()!);
      }
      return UserData.fromJson(snapshot.data()!);
    }
    return null;
  }

  //Check if the driver profile is updated
  Future<bool> checkIfProfileUpdated(String uid) async {
    // Query database to check if user has updated profile
    final snapshot = await tricycleCollection.doc(uid).get();
    // Return true or false
    if (snapshot.exists) {
      final data = TricycleData.fromMap(snapshot.data()!, snapshot.id);
      if (data.plateNumber != "") {
        return true;
      }
    }
    return false;
  }

  //Update tricycle data
  Future<bool> updateTricycleData(String plateNumber, String color) async {
    await tricycleCollection.doc(uid).update({
      "plateNumber": plateNumber,
      "color": color,
    });
    return true;
  }

  Stream<List<TricycleData>> readTricycleData() {
    return tricycleCollection
        .where('status', isEqualTo: true)
        .where("plateNumber", isNotEqualTo: "")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => TricycleData.fromJson(doc)).toList());
  }

  Future<TricycleData?> getTricycleData(String driveID) async {
    final snapshot = await tricycleCollection.doc(driveID).get();
    if (snapshot.exists) {
      return TricycleData.fromMap(snapshot.data()!, driveID);
    }
    return null;
  }

  Future<String> bookTricycle(String? userID, String? driverID, String to,
      String from, int seats) async {
    final docRef = await bookingCollection.add({
      'userID': userID,
      'driverID': driverID,
      'to': to,
      'from': from,
      'status': false,
      'seats': seats,
      'hasCompleted': false,
      'disapprove': false,
      'created': FieldValue.serverTimestamp()
    });
    return docRef.id;
  }

  Stream<Booking?> getBookingStatus(String? uid) {
    return bookingCollection.doc(uid).snapshots().map(
      (snapshot) {
        if (snapshot.exists) {
          return Booking.fromJson(snapshot.data()!);
        }
        return null;
      },
    );
  }

  Stream<List<BookingList>> getUserBookings(String? uid) {
    return bookingCollection
        .where('userID', isEqualTo: uid)
        .orderBy('created', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => BookingList.fromJson(doc)).toList(),
        );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserPendingBookings(
      String? uid) {
    return bookingCollection
        .where('userID', isEqualTo: uid)
        .where('status', isEqualTo: false)
        .where('disapprove', isEqualTo: false)
        .get();
  }

  Stream<WalletData?> getBalance(String uid) {
    return walletCollection.doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        walletData = WalletData.fromJson(snapshot.data()!);
        return walletData;
      }
      return null;
    });
  }

  Future<bool> setBalance(String uid, String balance) async {
    walletCollection.doc(uid).update({
      "balance": walletData!.balance + double.parse(balance),
    });
    return true;
  }

  Future<bool> disburseFunds(String uid, String amount) async {
    walletCollection.doc(uid).update({
      "balance": walletData!.balance - double.parse(amount),
    });
    return true;
  }

  Stream<UserData?> getUserProfile(String uid) {
    return usersCollection.doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserData.fromJson(snapshot.data()!);
      }
      return null;
    });
  }

  Future<bool> updateProfile(
    String uid,
    String name,
    String email,
    String phone,
  ) async {
    usersCollection.doc(uid).update({
      "email": email,
      "phone": phone,
      "name": name,
    });
    return true;
  }

  Future<bool> updateImage(File? image, String uid) async {
    filesCollection.child(uid).putFile(image!);
    return true;
  }

  Future<bool> setImage(String? uid) async {
    final ByteData byteData = await rootBundle.load("assets/user.png");
    final Uint8List imageData = byteData.buffer.asUint8List();
    filesCollection.child(uid!).putData(imageData);
    return true;
  }

  Stream<String?> getImage(String uid) {
    try {
      return filesCollection.child(uid).getDownloadURL().asStream();
    } catch (e) {
      return Stream.value(null);
    }
  }

  Stream<List<BookingList>> getDriverBookings(String? uid) {
    return bookingCollection
        .where('driverID', isEqualTo: uid)
        .where("status", isEqualTo: false)
        .where("disapprove", isEqualTo: false)
        .orderBy('created', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => BookingList.fromJson(doc)).toList(),
        );
  }

  Stream<List<BookingList>> getDriverRequestBookings(String? uid) {
    return bookingCollection
        .where('driverID', isEqualTo: uid)
        .where('status', isEqualTo: false)
        .where('disapproved', isEqualTo: false)
        .orderBy('created', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => BookingList.fromJson(doc)).toList(),
        );
  }

  Stream<List<BookingList>> getDriverApprovedBookings(String? uid) {
    return bookingCollection
        .where('driverID', isEqualTo: uid)
        .where('status', isEqualTo: true)
        .where('hasCompleted', isEqualTo: false)
        .where('disapprove', isEqualTo: false)
        .orderBy('created', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => BookingList.fromJson(doc)).toList(),
        );
  }

  Stream<TricycleData?> getRideStatus(String? uid) {
    return tricycleCollection.doc(uid).snapshots().map(
      (snapshot) {
        if (snapshot.exists) {
          return TricycleData.fromMap(snapshot.data()!, snapshot.id);
        }
        return null;
      },
    );
  }

  Future<bool> startRide(String? uid) async {
    try {
      // Get bookings where the status is pending
      final snapshot = await bookingCollection
          .where('driverID', isEqualTo: uid)
          .where('status', isEqualTo: false)
          .where('disapprove', isEqualTo: false)
          .get();

      final results = await Future.wait(snapshot.docs.map((doc) async {
        //Disapprove other bookings
        await bookingCollection.doc(doc.id).update({
          "disapprove": true,
        });
      }).toList());

      // update tricycleDetails
      await tricycleCollection.doc(uid).update({
        "hasStarted": true,
        "status": false,
      });

      // Check if all operations were successful
      final isSuccess = !results.contains(false);
      return isSuccess;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completeRide(String? uid) async {
    try {
      final snapshot = await bookingCollection
          .where('driverID', isEqualTo: uid)
          .where('status', isEqualTo: true)
          .where('hasCompleted', isEqualTo: false)
          .orderBy('created', descending: true)
          .get();

      dynamic driverPayment = 0;
      dynamic driverBalance = 0;
      String driverID = "";

      final results = await Future.wait(snapshot.docs.map((doc) async {
        dynamic amount = doc['seats'] * Constants.amount;

        driverID = doc['driverID'];

        driverPayment += amount;

        dynamic userBalance;

        // Get user balance
        final userSnapshot = await walletCollection.doc(doc['userID']).get();

        if (userSnapshot.exists) {
          var wallet = WalletData.fromJson(
            userSnapshot.data()!,
          );
          userBalance = wallet.balance;
        }

        // Make calculations
        final currentUserBalance = userBalance - amount;

        //Deduce user balance
        await walletCollection.doc(doc['userID']).update({
          "balance": currentUserBalance,
        });

        //complete other bookings
        await bookingCollection.doc(doc.id).update({
          "hasCompleted": true,
        });
      }).toList());

      // Get driver balance
      final driverSnapshot = await walletCollection.doc(driverID).get();
      if (driverSnapshot.exists) {
        var wallet = WalletData.fromJson(
          driverSnapshot.data()!,
        );
        driverBalance = wallet.balance;
        final currentDriverBalance = driverBalance + driverPayment;

        //Increase driver balance
        await walletCollection.doc(driverID).update({
          "balance": currentDriverBalance,
        });
      }

      // Check if all operations were successful
      final isSuccess = !results.contains(false);

      // update tricycleDetails
      await tricycleCollection.doc(uid).update({
        "hasStarted": false,
        "status": true,
        "pass": 4,
      });

      return isSuccess;
    } catch (e) {
      return false;
    }
  }

  Future<int?> getPassNumber(String driverID) async {
    final snapshot = await tricycleCollection.doc(driverID).get();
    if (snapshot.exists) {
      final data = snapshot.data()!;
      final pass = data['pass'];
      return pass;
    }
    return null;
  }

  Future<bool> hasBalance(String userID, dynamic amount) async {
    final userSnapshot = await walletCollection.doc(userID).get();
    if (userSnapshot.exists) {
      var wallet = WalletData.fromJson(
        userSnapshot.data()!,
      );
      if (wallet.balance >= amount) {
        return true;
      }
    }
    return false;
  }

  Future<bool> approveBooking(String uid) async {
    bookingCollection.doc(uid).update({
      "status": true,
    });
    return true;
  }

  Future<bool> disapproveBooking(String uid) async {
    bookingCollection.doc(uid).update({
      "disapprove": true,
    });
    return true;
  }

  Future<bool> updateSeatNo(String driverID, int number) async {
    await tricycleCollection.doc(uid).update({
      "pass": number,
    });
    return true;
  }

  Stream<TricycleData?> getSeats(String uid) {
    return tricycleCollection.doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return TricycleData.fromMap(snapshot.data()!, snapshot.id);
      }
      return null;
    });
  }
}
