import 'package:cloud_firestore/cloud_firestore.dart';

class BookingList {
  final String? id;
  final String driverID;
  final String userID;
  final String from;
  final String to;
  final bool status;

  BookingList({
    this.id,
    required this.driverID,
    required this.userID,
    required this.from,
    required this.to,
    required this.status,
  });

  factory BookingList.fromJson(DocumentSnapshot snapshot) {
    return BookingList(
        id: snapshot.id,
        driverID: snapshot['driverID'],
        userID: snapshot['userID'].toString(),
        from: snapshot['from'],
        to: snapshot['to'],
        status: snapshot['status']);
  }
}

class Booking {
  final String driverID;
  final String userID;
  final String from;
  final String to;
  final bool status;
  final DateTime? created;

  Booking({
    required this.driverID,
    required this.userID,
    required this.from,
    required this.to,
    required this.status,
    required this.created,
  });

  factory Booking.fromJson(Map<String, dynamic> snapshot) {
    return Booking(
      driverID: snapshot['driverID'],
      userID: snapshot['userID'],
      from: snapshot['from'],
      to: snapshot['to'],
      status: snapshot['status'],
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
      'created': created == null ? null : Timestamp.fromDate(created!),
    };
  }
}
