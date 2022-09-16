// ignore_for_file: avoid_print, non_constant_identifier_names, import_of_legacy_library_into_null_safe

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver_heat_map/config_map.dart';
import 'package:driver_heat_map/main.dart';
import 'package:driver_heat_map/models/ride_details.dart';
import 'package:driver_heat_map/notifications/notification_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotificationService {
  final FirebaseMessaging? firebaseMessaging = FirebaseMessaging.instance;

  Future initialize(context) async {
    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((message) => retrieveRideRequestInfo(getRideRequestId(message!.data), context));

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((message) {
      retrieveRideRequestInfo(getRideRequestId(message.data), context);
    });
    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      retrieveRideRequestInfo(getRideRequestId(message.data), context);
    });
    // firebaseMessaging!.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     retrieveRideRequestInfo(getRideRequestId(message), context);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     retrieveRideRequestInfo(getRideRequestId(message), context);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     retrieveRideRequestInfo(getRideRequestId(message), context);
    //   },
    // );
  }

  Future<String> getToken() async {
    String? token = await firebaseMessaging!.getToken();
    print("This is token :: ");
    print(token);
    driversRef.child(currentfirebaseUser!.uid).child("token").set(token);

    firebaseMessaging!.subscribeToTopic("alldrivers");
    firebaseMessaging!.subscribeToTopic("allusers");
    return token!;
  }

  String getRideRequestId(Map<String, dynamic> message) {
    String rideRequestId = "";
    if (Platform.isAndroid) {
      rideRequestId = message['data']['ride_request_id'];
    } else {
      rideRequestId = message['ride_request_id'];
    }

    return rideRequestId;
  }

  void retrieveRideRequestInfo(String rideRequestId, BuildContext context) {
    newRequestsRef.child(rideRequestId).once().then((DataSnapshot dataSnapShot) {
      if (dataSnapShot.value != null) {
        assetsAudioPlayer.open(Audio("assets/sounds/alert.mp3"));
        assetsAudioPlayer.play();

        double pickUpLocationLat = double.parse(dataSnapShot.value['pickup']['latitude'].toString());
        double pickUpLocationLng = double.parse(dataSnapShot.value['pickup']['longitude'].toString());
        String pickUpAddress = dataSnapShot.value['pickup_address'].toString();

        double dropOffLocationLat = double.parse(dataSnapShot.value['dropoff']['latitude'].toString());
        double dropOffLocationLng = double.parse(dataSnapShot.value['dropoff']['longitude'].toString());
        String dropOffAddress = dataSnapShot.value['dropoff_address'].toString();

        String paymentMethod = dataSnapShot.value['payment_method'].toString();

        String rider_name = dataSnapShot.value["rider_name"];
        String rider_phone = dataSnapShot.value["rider_phone"];

        RideDetails rideDetails = RideDetails();
        rideDetails.ride_request_id = rideRequestId;
        rideDetails.pickup_address = pickUpAddress;
        rideDetails.dropoff_address = dropOffAddress;
        rideDetails.pickup = LatLng(pickUpLocationLat, pickUpLocationLng);
        rideDetails.dropoff = LatLng(dropOffLocationLat, dropOffLocationLng);
        rideDetails.payment_method = paymentMethod;
        rideDetails.rider_name = rider_name;
        rideDetails.rider_phone = rider_phone;

        print("Information :: ");
        print(rideDetails.pickup_address);
        print(rideDetails.dropoff_address);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => NotificationDialog(
            rideDetails: rideDetails,
          ),
        );
      }
    });
  }
}
