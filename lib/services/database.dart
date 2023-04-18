import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tricycle/models/bookingList_data.dart';
import 'package:tricycle/models/tricycle_data.dart';
import 'package:tricycle/models/user_data.dart';
import 'package:tricycle/models/wallet_data.dart';
import 'package:flutter/services.dart';

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
  Future<UserData?> getUser(String uid) async {
    // Query database to get user type
    final snapshot = await usersCollection.doc(uid).get();
    // Return user type as string
    if (snapshot.exists) {
      userData = UserData.fromJson(snapshot.data()!);
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

  Future<String> bookTricycle(
      String? userID, String? driverID, String to, String from) async {
    final docRef = await bookingCollection.add({
      'userID': userID,
      'driverID': driverID,
      'to': to,
      'from': from,
      'status': false,
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
        .orderBy('created', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => BookingList.fromJson(doc)).toList(),
        );
  }

  Stream<bool> approveBooking(
      String uid) {
    bookingCollection.doc(uid).update({
      "status": true,
    });
    return Stream.value(true);
  }
}
