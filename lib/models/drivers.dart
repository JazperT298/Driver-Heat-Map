// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';

class Drivers {
  String? name;
  String? phone;
  String? email;
  String? imageUrl;
  String? id;
  String? car_color;
  String? car_model;
  String? car_number;

  Drivers({
    this.name,
    this.phone,
    this.email,
    this.imageUrl,
    this.id,
    this.car_color,
    this.car_model,
    this.car_number,
  });

  Drivers.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    phone = dataSnapshot.value["phone"];
    email = dataSnapshot.value["email"];
    name = dataSnapshot.value["name"];
    imageUrl = dataSnapshot.value["imageUrl"];
    car_color = dataSnapshot.value["car_details"]["car_color"];
    car_model = dataSnapshot.value["car_details"]["car_model"];
    car_number = dataSnapshot.value["car_details"]["car_number"];
  }
}
