// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, prefer_collection_literals, import_of_legacy_library_into_null_safe, unnecessary_new, avoid_unnecessary_containers, deprecated_member_use, use_build_context_synchronously, sized_box_for_whitespace, sort_child_properties_last, library_private_types_in_public_api, avoid_print, await_only_futures

import 'package:driver_heat_map/config_map.dart';
import 'package:driver_heat_map/datahandler/app_data.dart';
import 'package:driver_heat_map/screens/history_screen.dart';
import 'package:driver_heat_map/services/assistant_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EarningsTabPage extends StatefulWidget {
  @override
  State<EarningsTabPage> createState() => _EarningsTabPageState();
}

class _EarningsTabPageState extends State<EarningsTabPage> {
  PersistentBottomSheetController? _controller; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _groupValue = 0;
  MList? mLists;

  List<MList> mList = [
    MList(id: '1', title: 'All'),
    MList(id: '2', title: 'Last 24 hours'),
    MList(id: '3', title: 'Last 7 days'),
    MList(id: '4', title: 'Last 30 days'),
  ];

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
                //Delete Index after feature is solved
                Text(
                  'Total Earnings ',
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          print('selectedIndex 2 $selectedIndex');
                        },
                        icon: Icon(
                          Icons.filter_list_alt,
                          size: 30,
                          color: Colors.transparent,
                        ),
                      ),
                      Text(
                        "₱${Provider.of<AppData>(context, listen: false).earnings}",
                        style: TextStyle(color: Colors.white, fontSize: 50, fontFamily: 'Brand Bold'),
                      ),
                      IconButton(
                        onPressed: () {
                          // showBottomSheet(context);
                          // setState(() {});
                          showModalBottomSheet<void>(
                            isDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return DialogStatefull();
                            },
                          );
                        },
                        icon: Icon(
                          Icons.filter_list_alt,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
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
                  'assets/images/playstore.png',
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

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        isDismissible: false,
        builder: (builder) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: const Radius.circular(15.0), topRight: const Radius.circular(15.0))),
              child: Column(
                key: _scaffoldKey,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date Filter By :",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Brand Bold',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // myRadioButton(
                  //   title: "All",
                  //   value: 0,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       _groupValue = newValue;
                  //     });
                  //     setState(() {});
                  //   },
                  // ),
                  // myRadioButton(
                  //   title: "Last 24 hours",
                  //   value: 1,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       _groupValue = newValue;
                  //     });
                  //     setState(() {});
                  //   },
                  // ),
                  // myRadioButton(
                  //   title: "Last 7 days",
                  //   value: 2,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       _groupValue = newValue;
                  //     });
                  //     setState(() {});
                  //   },
                  // ),
                  // myRadioButton(
                  //   title: "Last 30 days",
                  //   value: 3,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       _groupValue = newValue;
                  //     });
                  //     setState(() {});
                  //   },
                  // ),
                  Column(
                    children: mList
                        .map((data) => RadioListTile<MList>(
                              title: Text(data.title!),
                              groupValue: mLists,
                              value: data,
                              onChanged: (val) {
                                setState(() {
                                  print('mLists ${mLists!.id!}');
                                  mLists = val;
                                });
                                setState(() {});
                              },
                            ))
                        .toList(),
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget myRadioButton({String? title, int? value, Function? onChanged}) {
    return RadioListTile<int?>(
      value: value,
      groupValue: _groupValue,
      onChanged: (value) {
        setState(() {
          onChanged!;
        });
      },
      title: Text(title!),
    );
  }
}

class DialogStatefull extends StatefulWidget {
  const DialogStatefull({Key? key}) : super(key: key);

  @override
  State<DialogStatefull> createState() => _DialogStatefullState();
}

class _DialogStatefullState extends State<DialogStatefull> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, state) {
      return Container(
        height: 280,
        // color: Colors.amber,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date Filter By :",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Brand Bold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print('selectedIndex $selectedIndex');
                        Navigator.pop(context, selectedIndex);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              customRadio("All", 0),
              customRadio("Last 24 hours", 1),
              customRadio("Last 7 days", 2),
              customRadio("Last 30 days", 3),
            ],
          ),
        ),
      );
    });
  }

  Widget customRadio(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selected = index;
          selectedIndex = selected;
          print(index);
          print(selected);
          if (selected == 0) {
            AssistantServices.retrieveHistoryInfo(context);
          } else if (selected == 1) {
            AssistantServices.retrieveHistoryInfo(context);
          } else if (selected == 2) {
            AssistantServices.retrieveHistoryInfo(context);
          } else if (selected == 3) {
            AssistantServices.retrieveHistoryInfo(context);
          }
        });
        setState(() {});
        // Navigator.pop(context);
      },
      child: Text(
        text,
        style: TextStyle(color: (selected == index) ? Colors.white : Colors.grey),
      ),
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: (selected == index) ? Colors.black87 : Colors.white,
      ),
    );
  }
}

class MList {
  String? id;
  String? title;

  MList({this.id, this.title});
}
