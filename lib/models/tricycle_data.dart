import 'package:cloud_firestore/cloud_firestore.dart';

class TricycleData {
  final String id;
  final String color;
  final String plateNumber;
  final bool hasCompleted;
  final int pass;
  final bool status;

  TricycleData({
    required this.id,
    required this.color,
    required this.plateNumber,
    required this.hasCompleted,
    required this.pass,
    required this.status,
  });

  factory TricycleData.fromJson(DocumentSnapshot snapshot) {
    return TricycleData(
      id: snapshot.id,
      color: snapshot['color'],
      plateNumber: snapshot['plateNumber'],
      hasCompleted: snapshot['hasCompleted'],
      pass: snapshot['pass'],
      status: snapshot['status'],
    );
  }
  factory TricycleData.fromMap(Map<String, dynamic> map, String id) {
  return TricycleData(
    id: id,
    color: map['color'],
    plateNumber: map['plateNumber'],
    hasCompleted: map['hasCompleted'],
    pass: map['pass'],
    status: map['status'],
  );
}
}
