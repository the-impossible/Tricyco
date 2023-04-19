import 'package:cloud_firestore/cloud_firestore.dart';

class BookingList {
  final String? id;
  final String driverID;
  final String userID;
  final String from;
  final String to;
  final bool status;
  final bool hasCompleted;
  final DateTime? created;

  BookingList({
    this.id,
    required this.driverID,
    required this.userID,
    required this.from,
    required this.to,
    required this.status,
    required this.hasCompleted,
    required this.created,
  });

  factory BookingList.fromJson(DocumentSnapshot snapshot) {
    return BookingList(
      id: snapshot.id,
      driverID: snapshot['driverID'],
      userID: snapshot['userID'],
      from: snapshot['from'],
      to: snapshot['to'],
      status: snapshot['status'],
      hasCompleted: snapshot['hasCompleted'],
      created: (snapshot['created'] as Timestamp).toDate(),
    );
  }
}

class Booking {
  final String driverID;
  final String userID;
  final String from;
  final String to;
  final bool status;
  final bool hasCompleted;
  final DateTime? created;

  Booking({
    required this.driverID,
    required this.userID,
    required this.from,
    required this.to,
    required this.status,
    required this.hasCompleted,
    required this.created,
  });

  factory Booking.fromJson(Map<String, dynamic> snapshot) {
    return Booking(
      driverID: snapshot['driverID'],
      userID: snapshot['userID'],
      from: snapshot['from'],
      to: snapshot['to'],
      status: snapshot['status'],
      hasCompleted: snapshot['hasCompleted'],
      created: (snapshot['created'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'driverID': driverID,
      'to': to,
      'from': from,
      'status': status,
      'hasCompleted': hasCompleted,
      'created': created == null ? null : Timestamp.fromDate(created!),
    };
  }
}
