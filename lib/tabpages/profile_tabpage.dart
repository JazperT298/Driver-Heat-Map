// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, prefer_collection_literals, import_of_legacy_library_into_null_safe, unnecessary_new, avoid_unnecessary_containers, deprecated_member_use, use_build_context_synchronously, sized_box_for_whitespace, sort_child_properties_last, library_private_types_in_public_api, avoid_print

import 'package:driver_heat_map/config_map.dart';
import 'package:driver_heat_map/main.dart';
import 'package:driver_heat_map/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
// import 'package:flutter_geofire/flutter_geofire.dart';

class ProfileTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //   return Scaffold(
    //     backgroundColor: Colors.black87,
    //     body: SafeArea(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             driversInformation!.name!,
    //             style: TextStyle(
    //               fontSize: 65.0,
    //               color: Colors.white,
    //               fontWeight: FontWeight.bold,
    //               fontFamily: 'Signatra',
    //             ),
    //           ),
    //           Text(
    //             title + " driver",
    //             style: TextStyle(
    //                 fontSize: 20.0, color: Colors.blueGrey[200], letterSpacing: 2.5, fontWeight: FontWeight.bold, fontFamily: 'Brand-Regular'),
    //           ),
    //           SizedBox(
    //             height: 20,
    //             width: 200,
    //             child: Divider(
    //               color: Colors.white,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 40.0,
    //           ),
    //           InfoCard(
    //             text: driversInformation!.phone!,
    //             icon: Icons.phone,
    //             onPressed: () async {
    //               print("this is phone.");
    //             },
    //           ),
    //           InfoCard(
    //             text: driversInformation!.email!,
    //             icon: Icons.email,
    //             onPressed: () async {
    //               print("this is email.");
    //             },
    //           ),
    //           InfoCard(
    //             text: driversInformation!.car_color! + " " + driversInformation!.car_model! + " " + driversInformation!.car_number!,
    //             icon: Icons.car_repair,
    //             onPressed: () async {
    //               print("this is car info.");
    //             },
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               Geofire.removeLocation(currentfirebaseUser!.uid);
    //               rideRequestRef.onDisconnect();
    //               rideRequestRef.remove();
    //               rideRequestRef = null as DatabaseReference;

    //               FirebaseAuth.instance.signOut();
    //               Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
    //             },
    //             child: Card(
    //               color: Colors.red,
    //               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 110.0),
    //               child: ListTile(
    //                 trailing: Icon(
    //                   Icons.follow_the_signs_outlined,
    //                   color: Colors.white,
    //                 ),
    //                 title: Text(
    //                   "Sign out",
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 16.0,
    //                     fontFamily: 'Brand Bold',
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
// }
    return Scaffold(
      body: Material(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.black87,
                              Colors.black54,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 30.0,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 240,
                          child: GestureDetector(
                            child: Container(
                              alignment: Alignment(0.0, 1.7),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 60.0,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/user_icon.png'),
                                  radius: 59.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Text(
                      driversInformation!.name!,
                      style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Signatra',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 5,
                      bottom: 0,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ratings : ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16, //theme.textTheme.subtitle1!.fontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Brand-Regular'),
                              ),
                              Text(
                                title + " driver",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Brand-Regular'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 5,
                      bottom: 0,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phone Number : ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16, // theme.textTheme.subtitle1!.fontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Brand-Regular'),
                              ),
                              Text(
                                driversInformation!.phone!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16, // theme.textTheme.subtitle1!.fontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Brand-Regular'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 5,
                      bottom: 0,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Email : ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16, // theme.textTheme.subtitle1!.fontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Brand-Regular'),
                              ),
                              Text(
                                driversInformation!.email!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16, // theme.textTheme.subtitle1!.fontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Brand-Regular'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 5,
                      bottom: 0,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Geofire.removeLocation(currentfirebaseUser!.uid);
                          rideRequestRef.onDisconnect();
                          rideRequestRef.remove();
                          rideRequestRef = null as DatabaseReference;

                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Signout',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16, //theme.textTheme.subtitle1!.fontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Brand-Regular'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 5,
                      bottom: 0,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Delete account',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String? text;
  final IconData? icon;
  Function? onPressed;

  InfoCard({
    this.text,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed!;
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black87,
          ),
          title: Text(
            text!,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontFamily: 'Brand Bold',
            ),
          ),
        ),
      ),
    );
  }
}
