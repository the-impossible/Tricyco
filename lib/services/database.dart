import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tricycle/models/tricycle_data.dart';
import 'package:tricycle/models/user_data.dart';

class DatabaseService extends GetxController {
  String? uid;
  DatabaseService({this.uid});

  UserData? userData;

  // collection reference
  var usersCollection =
      FirebaseFirestore.instance.collection("users");

  var tricycleCollection =
      FirebaseFirestore.instance.collection("tricycleData");

  Future createUserData(
      String name, String email, String phone, String userType) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'userType': userType,
    });
  }

Future<String> getUserType(String uid) async {
    // Query database to get user type
    final snapshot = await usersCollection.doc(uid).get();
    // Return user type as string
    if (snapshot.exists) {
      userData = UserData.fromJson(snapshot.data()!);
      return UserData.fromJson(snapshot.data()!).userType;
    }
    return "";
  }

  Future<bool> checkIfProfileUpdated(String uid) async {
    // Query database to check if user has updated profile
    final snapshot = await tricycleCollection.doc(uid).get();
    // Return true or false
    if (snapshot.exists) {
      final data = TricycleData.fromJson(snapshot.data()!);
      (data.plateNumber != "") ? true : false;
    }
    return false;
  }

  Future updateTricycleData(String plateNumber, String color) async {
    return await tricycleCollection.doc(uid).set({
      "plateNumber": plateNumber,
      "color": color,
    });
  }


  // Stream<DocumentSnapshot> get tricycleData {
  //   return tricycleCollection.doc(uid).snapshots();
  // }

  // Stream<TricycleData> get tricycleData {
  //   return TricycleData.fromDocumentSnapshot(
  //       tricycleCollection.doc(uid).snapshots());
  // }

  // Stream<QuerySnapshot> get user {
  //   return usersCollection.snapshots();
  // }

}
