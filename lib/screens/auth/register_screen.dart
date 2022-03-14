import 'dart:typed_data';

import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/widgets/common_elevated_button.dart';
import 'package:anihub_flutter/widgets/common_single_child_scroll.dart';
import 'package:anihub_flutter/widgets/network_image.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Uint8List? _backgroundPic;
  Uint8List? _profilePic;

  chooseImage(bool isBackgroundPic) {}

  _pickImageDialog(bool isBackgroundPic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: mainOrange,
          titleTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.black),
          title: Text(
              'Choose a ${isBackgroundPic ? "background" : "profile"} image'),
          content: Text(
              "Do you want to choose a custom ${isBackgroundPic ? "background" : "profile"} image or one from our pre-made ones?"),
          actions: [
            // CLOSE OPTION
            CommonElevatedButton(
              backgroundColor: Colors.red[400],
              onPress: () {
                Navigator.pop(context);
              },
              buttonChild: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            // GALLERY OPTION
            CommonElevatedButton(
              onPress: () {},
              buttonChild: const Text(
                'Gallery',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            // PRE-MADE OPTION
            CommonElevatedButton(
              backgroundColor: goodGreen,
              onPress: () {},
              buttonChild: const Text(
                'Pre-made',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: CommonSingleChildScroll(
            childWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // AVATAR CONTAINER
                InkWell(
                  onTap: () => _pickImageDialog(true),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // BACKGROUND IMAGE CONTAINER
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration:
                            const BoxDecoration(color: inputBackgroundColor),
                        child: CommonNetworkImage(
                          imageUrl: backgroundPics[0],
                        ),
                      ),
                      // CHOOSE BACKGROUND BUTTON
                      Positioned(
                        bottom: -15,
                        right: 10,
                        child: Center(
                          child: Container(
                            // margin: const EdgeInsets.only(bottom: 40),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: mainOrange,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: mainGrey),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              // size: 30,
                            ),
                          ),
                        ),
                      ),

                      // PROFILE IMAGE CONTAINER
                      Positioned.fill(
                        bottom: -50,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 120,
                            decoration: const BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () => _pickImageDialog(false),
                                child: Container(
                                  // clipBehavior: Clip.hardEdge,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: mainGrey,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: CommonNetworkImage(
                                            imageUrl: profilePics[0],
                                          ),
                                        ),
                                      ),
                                      // ADD ICON
                                      Positioned(
                                        bottom: -10,
                                        right: -10,
                                        child: Container(
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: mainOrange,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
