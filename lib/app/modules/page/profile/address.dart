import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  String id;
  String address;
  Timestamp createdAt;

  Address({
    required this.id,
    required this.address,
    required this.createdAt,
  });

  factory Address.fromJson(Map<String, dynamic> json, String id) {
    return Address(
      id: id,
      address: json['address'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'createdAt': createdAt,
    };
  }
}
