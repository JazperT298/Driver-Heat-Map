// ignore_for_file: import_of_legacy_library_into_null_safe, avoid_print

import 'package:driver_heat_map/config_map.dart';
import 'package:driver_heat_map/datahandler/app_data.dart';
import 'package:driver_heat_map/main.dart';
import 'package:driver_heat_map/models/direct_details.dart';
import 'package:driver_heat_map/models/history.dart';
import 'package:driver_heat_map/services/request_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
// import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AssistantServices {
  static Future<DirectionDetails?> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestServices.getRequest(directionUrl);

    if (res == "failed") {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints = res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  static int calculateFares(DirectionDetails directionDetails) {
    //in terms USD
    double timeTraveledFare = (directionDetails.durationValue! / 60) * 0.10;
    double distancTraveledFare = (directionDetails.distanceValue! / 1000) * 0.10;
    double totalFareAmount = timeTraveledFare + distancTraveledFare;
    int fares = 10;
    //Local Currency
    //1$ = 160 RS
    //double totalLocalAmount = totalFareAmount * 160;
    // if (rideType == "Taxi") {
    //   double result = (totalFareAmount.truncate()) * 2.0;
    //   return result.truncate();
    // } else if (rideType == "Motorela") {
    //   return totalFareAmount.truncate();
    // } else if (rideType == "Motorcycle") {
    //   double result = (totalFareAmount.truncate()) / 2.0;
    //   return result.truncate();
    // } else {
    //   return totalFareAmount.truncate();
    // }
    return fares;
  }

  static void disableHomeTabLiveLocationUpdates() {
    homeTabPageStreamSubscription!.pause();
    Geofire.removeLocation(currentfirebaseUser!.uid);
  }

  static void enableHomeTabLiveLocationUpdates() {
    homeTabPageStreamSubscription!.resume();
    Geofire.setLocation(currentfirebaseUser!.uid, currentPosition!.latitude, currentPosition!.longitude);
  }

  static void retrieveHistoryInfo(context) {
    //retrieve and display Earnings
    driversRef.child(currentfirebaseUser!.uid).child("earnings").once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        String earnings = dataSnapshot.value.toString();
        Provider.of<AppData>(context, listen: false).updateEarnings(earnings);
      }
    });

    //retrieve and display Trip History
    driversRef.child(currentfirebaseUser!.uid).child("history").once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        //update total number of trip counts to provider
        Map<dynamic, dynamic> keys = dataSnapshot.value;
        int tripCounter = keys.length;
        Provider.of<AppData>(context, listen: false).updateTripsCounter(tripCounter);

        //update trip keys to provider
        List<String> tripHistoryKeys = [];
        keys.forEach((key, value) {
          tripHistoryKeys.add(key);
        });
        Provider.of<AppData>(context, listen: false).updateTripKeys(tripHistoryKeys);
        obtainTripRequestsHistoryData(context);
      }
    });
  }

  static void retrieveHistoryInfo1Day(context) {
    // rideRequestRef.child(id).orderByKey().startAt(formattedDate).endAt(formattedDate1).once().then((DataSnapshot dataSnapshot) {
    //   print('dataSnapshot ${dataSnapshot.value}');
    //   if (dataSnapshot.value != null) {
    //     var history = History.fromSnapshot(dataSnapshot);
    //     Provider.of<AppData>(context, listen: false).updateTripHistoryData(history);
    //   }
    // });
    var keys = Provider.of<AppData>(context, listen: false).tripHistoryKeys;
    var now = DateTime.now();
    var now_24 = now.subtract(const Duration(hours: 24));
    var now_1w = now.subtract(const Duration(days: 7));
    var now_1m = DateTime(now.year, now.month - 1, now.day);
    var now_1y = DateTime(now.year - 1, now.month, now.day);

    DateTime startDate = DateTime.now();
    int epochTimestamp = startDate.millisecondsSinceEpoch;
    DateTime endDate = DateTime.now();
    var now_24s = endDate.subtract(const Duration(hours: 24));
    print('dataSnapshot1 $now_24s');
    int epochTimestamp2 = now_24s.millisecondsSinceEpoch;
    print('dataSnapshot1 $epochTimestamp2');
    var now_1ws = endDate.subtract(const Duration(days: 7));
    print('dataSnapshot1 $now_1ws');
    int epochTimestamp3 = now_1ws.millisecondsSinceEpoch;
    print('dataSnapshot1 $epochTimestamp3');

    // final startAtTimestamp = Timestamp.fromMillisecondsSinceEpoch(DateTime.parse('2019-03-13 16:49:42.044').millisecondsSinceEpoch);
    var timestampssss = DateTime.now().millisecondsSinceEpoch;
    var dateTimess = DateTime.fromMillisecondsSinceEpoch(timestampssss * 1000);

    for (String key in keys) {
      newRequestsRef
          .child(key)
          .orderByChild('create_at')
          // .startAt('2022-10-10 21:26:16.968763')
          // .endAt(formattedDate)
          // .orderByKey()

          .startAt("2022-10-15 08:56:00.032625") //DateTime.now().millisecondsSinceEpoch).
          // .endAt([
          //   {'create_at': DateTime.parse('2022-11-06 16:49:42.044')}
          // ])
          // .startAt(epochTimestamp)
          // .endAt(epochTimestamp3)
          .once()
          //     .onChildAdded
          //     .listen((event) {
          //   print('dataSnapshot1 ${event.snapshot.value}');
          // });
          .then((DataSnapshot snapshot) {
        // newRequestsRef.child(key).orderByKey().startAt(timestamp1day).endAt(timestamp).once().then((DataSnapshot snapshot) {
        print('dataSnapshot1 ${snapshot.value}');
        if (snapshot.value != null) {
          var history = History.fromSnapshot(snapshot);
          Provider.of<AppData>(context, listen: false).updateTripHistoryData(history);
        }
      });
    }
  }

  static void retrieveHistoryInfo7Day() {}
  static void retrieveHistoryInfo1Month() {}

  static void obtainTripRequestsHistoryData(context) {
    var keys = Provider.of<AppData>(context, listen: false).tripHistoryKeys;

    for (String key in keys) {
      newRequestsRef.child(key).once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var history = History.fromSnapshot(snapshot);
          Provider.of<AppData>(context, listen: false).updateTripHistoryData(history);
        }
      });
    }
  }

  static String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }
}
