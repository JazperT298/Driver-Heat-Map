// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, prefer_collection_literals, import_of_legacy_library_into_null_safe, unnecessary_new, avoid_unnecessary_containers, deprecated_member_use, use_build_context_synchronously, sized_box_for_whitespace, sort_child_properties_last, library_private_types_in_public_api, avoid_print, await_only_futures

import 'package:driver_heat_map/datahandler/app_data.dart';
import 'package:driver_heat_map/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EarningsTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black87,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 70),
            child: Column(
              children: [
                Text(
                  'Total Earnings',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "\$${Provider.of<AppData>(context, listen: false).earnings}",
                  style: TextStyle(color: Colors.white, fontSize: 50, fontFamily: 'Brand Bold'),
                )
              ],
            ),
          ),
        ),
        FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/uberx.png',
                  width: 70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Total Trips',
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                    child: Container(
                        child: Text(
                  Provider.of<AppData>(context, listen: false).countTrips.toString(),
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 18),
                ))),
              ],
            ),
          ),
        ),
        Divider(
          height: 2.0,
          thickness: 2.0,
        ),
      ],
    );
  }
}
