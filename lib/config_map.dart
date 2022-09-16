import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver_heat_map/models/drivers.dart';
import 'package:driver_heat_map/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

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
