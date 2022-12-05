import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver_heat_map/models/drivers.dart';
import 'package:driver_heat_map/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

String mapKey = "AIzaSyBHekMm3Io_ftJUd-FGapD5nqGCffbPcAw";

User? firebaseUser;

Users? userCurrentInfo;

User? currentfirebaseUser;

StreamSubscription<Position>? homeTabPageStreamSubscription;

StreamSubscription<Position>? rideStreamSubscription;

final assetsAudioPlayer = AssetsAudioPlayer();

Position? currentPosition;

Drivers? driversInformation;

String title = "";
double starCounter = 0.0;

String rideType = "";
int selectedIndex = 0;
DateTime now = DateTime.now();
int timestamp = DateTime.now().millisecondsSinceEpoch;
int timestamp1day = DateTime(now.year, now.month, now.day - 1).millisecondsSinceEpoch;

// DateTime now = DateTime.now().toUtc();
String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
var newMinus1Month = DateTime(now.year, now.month - 1, now.day);
String formattedDate1 = DateFormat('yyyy-MM-dd HH:mm:ss').format(newMinus1Month);
var newMinus1Day = DateTime(now.year, now.month, now.day - 1);
String formattedDate2 = DateFormat('yyyy-MM-dd HH:mm:ss').format(newMinus1Day);
var newMinus7Day = DateTime(now.year, now.month, now.day - 7);
String formattedDate3 = DateFormat('yyyy-MM-dd HH:mm:ss').format(newMinus7Day);
