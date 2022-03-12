import 'dart:typed_data';

import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/widgets/common_single_child_scroll.dart';
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
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // BACKGROUND IMAGE CONTAINER
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration:
                          const BoxDecoration(color: inputBackgroundColor),
                      child: Center(
                        child: InkWell(
                          onTap: () => chooseImage(true),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: mainOrange,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: mainGrey),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
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
                              onTap: () => chooseImage(false),
                              child: Container(
                                // clipBehavior: Clip.hardEdge,
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: mainGrey,
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3),
                                        child: Image.network(
                                          defaultProfilePicUrl,
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
