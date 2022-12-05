// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, prefer_collection_literals, import_of_legacy_library_into_null_safe, unnecessary_new, avoid_unnecessary_containers, deprecated_member_use, use_build_context_synchronously, sized_box_for_whitespace, sort_child_properties_last

import 'dart:io';

import 'package:driver_heat_map/config_map.dart';
import 'package:driver_heat_map/main.dart';
import 'package:driver_heat_map/screens/carinfo_screen.dart';
import 'package:driver_heat_map/screens/login_screen.dart';
import 'package:driver_heat_map/widgets/progress_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  static const String idScreen = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  bool isObscure = true;
  File? image;
  String filenamewholeImage = '';
  String filenamevideoprofile = '';
  String fileTypevideoprofile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 45.0,
              ),
              Image(
                image: AssetImage("assets/images/playstore.png"),
                width: 160.0,
                height: 100.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1.0,
              ),
              Text(
                "Register as a Driver",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold", fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child:
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 40.0,
                          child: image == null
                              ? CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/user_icon.png'),
                                  radius: 39.0,
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: 39.0,
                                ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        RaisedButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          child: Text(
                            "Choose File",
                            style: TextStyle(fontSize: 10),
                          ),
                          onPressed: () {
                            // setState(() {});
                            getSelectedImage();
                            // setState(() {});
                          },
                        ),
                      ],
                    ),
                    // ),

                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              if (isObscure == false) {
                                isObscure = true;
                              } else {
                                isObscure = false;
                              }
                            });
                          },
                          child: isObscure != false
                              ? Text(
                                  'SHOW',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              : Text(
                                  'HIDE',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        //validation for register user
                        if (image == null) {
                          displayToastMessage("Please select image profile.", context);
                        } else if (nameTextEditingController.text.length < 3) {
                          displayToastMessage("Name must be atleast 3 Characters.", context);
                        } else if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("Email address is not Valid.", context);
                        } else if (phoneTextEditingController.text.isEmpty) {
                          displayToastMessage("Phone Number is mandatory.", context);
                        } else if (phoneTextEditingController.text.length < 11) {
                          displayToastMessage("Phone Number must be 11 digits.", context);
                        } else if (!phoneTextEditingController.text.startsWith('09')) {
                          displayToastMessage("Phone Number must start with 09", context);
                        } else if (passwordTextEditingController.text.length < 6) {
                          displayToastMessage("Password must be atleast 6 Characters.", context);
                        } else {
                          registerNewUser(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Already have an Account? Login Here",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //select image
  Future getSelectedImage() async {
    final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'png'],
    );
    if (pickedFile != null) {
      final File imgprofile = File(pickedFile.files.single.path!);

      try {
        image = imgprofile;
        filenamewholeImage = imgprofile.path.split('/').last;
        var splitTheimage = filenamewholeImage.split('.');
        filenamevideoprofile = splitTheimage[0];
        fileTypevideoprofile = splitTheimage[1];
      } catch (e) {
        image = null;
      }
      setState(() {});
    } else {}
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Funaction register user to database
  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Registering, Please wait...",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(email: emailTextEditingController.text, password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) //user created
    {
      //save user info to database
      // String fileName = basename(image!.path),
      Reference storageRef = FirebaseStorage.instance.ref().child('uploads/$filenamevideoprofile');
      UploadTask uploadTask = storageRef.putFile(image!);
      TaskSnapshot downloadUrl = (await uploadTask);
      String urlString = await downloadUrl.ref.getDownloadURL();
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "imageUrl": urlString,
      };

      driversRef.child(firebaseUser.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;

      displayToastMessage("Congratulations, your account has been created.", context);

      Navigator.pushNamed(context, CarInfoScreen.idScreen);
    } else {
      Navigator.pop(context);
      //error occured - display error msg
      displayToastMessage("New user account has not been Created.", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
