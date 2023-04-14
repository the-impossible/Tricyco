import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tricycle/models/bookingList_data.dart';
import 'package:tricycle/models/tricycle_data.dart';
import 'package:tricycle/models/user_data.dart';

class DatabaseService extends GetxController {
  String? uid;
  DatabaseService({this.uid});

  UserData? userData;

  // collection reference
  var usersCollection = FirebaseFirestore.instance.collection("users");
  var bookingCollection = FirebaseFirestore.instance.collection("BookingList");
  var tricycleCollection =
      FirebaseFirestore.instance.collection("tricycleData");

  //Create user
  Future createUserData(
      String name, String email, String phone, String userType) async {
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
      'status': false
    });
    return docRef.id;
  }

  Stream<BookingList?> getBookingStatus(String? uid) {
    return bookingCollection.doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return BookingList.fromJson(snapshot.data()!);
      }
      return null;
    });
  }

  Stream<List<BookingList>> getUserBookings(String? uid) {
    return bookingCollection.where('userID', isEqualTo: uid).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => BookingList.fromJson(doc.data()))
              .toList(),
        ); // Fixed: call .data() on the document snapshot to get the data map
  }

  //   Future<TricycleData?> getBookingData(String bookingID) async {
  //   final snapshot = await tricycleCollection.doc(driveID).get();
  //   if (snapshot.exists) {
  //     return TricycleData.fromMap(snapshot.data()!, driveID);
  //   }
  //   return null;
  // }

  // Stream<TricycleData> get tricycleData {
  //   return TricycleData.fromDocumentSnapshot(
  //       tricycleCollection.doc(uid).snapshots());
  // }

  // Stream<QuerySnapshot> get user {
  //   return usersCollection.snapshots();
  // }

}
