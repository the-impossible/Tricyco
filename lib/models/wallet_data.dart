import 'package:cloud_firestore/cloud_firestore.dart';

class WalletData {
  final dynamic balance;

  WalletData({
    required this.balance,
  });

  factory WalletData.fromJson(Map<String, dynamic> snapshot) {
    return WalletData(balance: snapshot['balance']);
  }
}
