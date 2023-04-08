import 'package:cloud_firestore/cloud_firestore.dart';

class TricycleData {
  final String color;
  final String plateNumber;

  TricycleData({
    required this.color,
    required this.plateNumber,
  });

  factory TricycleData.fromJson(Map<String, dynamic> snapshot) {
    return TricycleData(
        color: snapshot['color'],
        plateNumber: snapshot['plateNumber']);
  }

}
