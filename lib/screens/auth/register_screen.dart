import 'dart:typed_data';

import 'package:anihub_flutter/back_end_methods/auth_methods.dart';
import 'package:anihub_flutter/screens/auth/premade_image_picker_screen.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/utils/functions.dart';
import 'package:anihub_flutter/widgets/common_elevated_button.dart';
import 'package:anihub_flutter/widgets/common_input.dart';
import 'package:anihub_flutter/widgets/common_single_child_scroll.dart';
import 'package:anihub_flutter/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Uint8List? _backgroundPic;
  Uint8List? _profilePic;

  String? _backgroundPremadePic = getRandomItem(backgroundPics);
  String? _profilePremadePic = getRandomItem(profilePics);

  // PASSWORD FIELD IS VISIBLE
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();

    _usernameController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
  }

  // PICK IMAGE FUNCTION
  _pickImageGallery(
      {required bool isBackgroundPic, required bool isCamera}) async {
    // CHECK FOR PERMISSIONS
    if (await hasPickImagePermission(isCamera)) {
      Uint8List? picked =
          await pickImage(isCamera ? ImageSource.camera : ImageSource.gallery);

      if (picked != null) {
        setState(() {
          if (isBackgroundPic) {
            _backgroundPic = picked;
            _backgroundPremadePic = null;
          } else {
            _profilePic = picked;
            _profilePremadePic = null;
          }
        });
      }
    }
  }

  // DIALOG THAT APPEARS WHEN USER CLICKS IN BACKGROUND OR PROFILE PICS
  _pickImageDialog(bool isBackgroundPic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dialogBackground,
          titleTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.black),
          title: const Icon(
            Icons.image,
            color: darkBlue,
            size: 50,
          ),
          content: Text(
            "Do you want to choose a custom ${isBackgroundPic ? "background" : "profile"} image or one from our pre-made ones?",
          ),
          actions: [
            // // CLOSE OPTION
            // CommonElevatedButton(
            //   backgroundColor: Colors.red[400],
            //   onPress: () {
            //     Navigator.pop(context);
            //   },
            //   buttonChild: const Text(
            //     'Close',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),

            // CAMERA OPTION
            CommonElevatedButton(
              backgroundColor: blue,
              onPress: () {
                // CLOSE DIALOG
                Navigator.of(context).pop();

                _pickImageGallery(
                    isBackgroundPic: isBackgroundPic, isCamera: true);
              },
              buttonChild: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: const [
                    Icon(Icons.add_a_photo),
                    Text('Camera'),
                  ],
                ),
              ),
            ),
            // GALLERY OPTION
            CommonElevatedButton(
              onPress: () {
                // CLOSE DIALOG
                Navigator.of(context).pop();

                _pickImageGallery(
                    isBackgroundPic: isBackgroundPic, isCamera: false);
              },
              buttonChild: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: const [Icon(Icons.menu), Text("Gallery")],
                ),
              ),
            ),
            // PRE-MADE OPTION
            CommonElevatedButton(
              backgroundColor: goodGreen,
              onPress: () {
                // CLOSE DIALOG
                Navigator.pop(context);

                // NAVIGATE TO PICK PRE-MADE IMAGES SCREEN
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PremadeImagePickerScreen(
                      initiallySelectedPic: isBackgroundPic
                          ? _backgroundPremadePic
                          : _profilePremadePic,
                      isBackgroundPic: isBackgroundPic,
                      onConfirmSelect: (selectedImage) {
                        Navigator.pop(context);
                        if (selectedImage != null) {
                          setState(() {
                            if (isBackgroundPic) {
                              _backgroundPremadePic = selectedImage;
                              _backgroundPic = null;
                            } else {
                              _profilePremadePic = selectedImage;
                              _profilePic = null;
                            }
                          });
                        }
                      },
                    ),
                  ),
                );
              },
              buttonChild: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: const [
                    Icon(Icons.check_box),
                    Text('Pre-made'),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // REGISTER BUTTON CLICKED
  onRegisterBtnClicked() async {
    bool isInputValid = true;
    String? invalidSnackbarMessage;

    // VALIDATION OF DATA INPUTTED
    if (_passwordController.text.length < 6) {
      isInputValid = false;
      invalidSnackbarMessage =
          'Password needs to be at least 6 characters long!';
    } else if (_confirmPasswordController.text != _passwordController.text) {
      isInputValid = false;
      invalidSnackbarMessage = "Passwords don't match!";
    } else if (_usernameController.text.isEmpty) {
      isInputValid = false;
      invalidSnackbarMessage = "Please fill all fields.";
    } else if (!isEmailValid(_emailController.text)) {
      isInputValid = false;
      invalidSnackbarMessage = "Please enter a valid email address!";
    }

    if (!isInputValid) {
      showFlushBar(
        context: context,
        title: 'Invalid input',
        message: invalidSnackbarMessage!,
        icon: const Icon(Icons.info),
        leftBarIndicatorColor: badRed,
      );
    } else {
      // SET LOADING TO TRUE (MAKE CIRCULAR PROGRESS INDICATOR APPEAR IN REGISTER BUTTON)
      setState(() {
        _isLoading = true;
      });

      // CALL SIGNUP METHOD.
      String signUpResult = await AuthMethods().signUp(
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        premadeBackgroundPic: _backgroundPremadePic,
        premadeProfilePic: _profilePremadePic,
        backgroundPic: _backgroundPic,
        profilePic: _profilePic,
      );

      // SET LOADING TO FALSE
      setState(() {
        _isLoading = false;
      });
      // IF NOT SUCCESS, SHOW FLUSH SNACKBAR
      if (signUpResult != SUCCESS_VALUE) {
        showFlushBar(
          context: context,
          title: 'Something wrong happened',
          message: signUpResult,
        );
      } else {
        Navigator.of(context).pop();
      }
    }
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
                backgroundProfilePicWidgets(),
                // INSIBLE CONTAINER TO LIST TO PROFILE CLICKS
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 75,
                    child: GestureDetector(
                      onTap: () => _pickImageDialog(false),
                    ),
                  ),
                ),
                // const Divider(
                //   thickness: 2,
                // ),

                // OTHER INPUTS
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          // USERNAME
                          CommonInput(
                            controller: _usernameController,
                            hintText: "Username",
                            prefixWidget: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                FontAwesomeIcons.user,
                                size: ICON_SIZE,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // EMAIL
                          CommonInput(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            hintText: "Email",
                            prefixWidget: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                FontAwesomeIcons.at,
                                size: ICON_SIZE,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // PASSWORD
                          CommonInput(
                            maxLines: 1,
                            controller: _passwordController,
                            hintText: "Password",
                            isVisible: _isPasswordVisible,
                            prefixWidget: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.lock,
                                size: ICON_SIZE,
                              ),
                            ),
                            suffixWidget: InkWell(
                              onTap: () => setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              }),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(!_isPasswordVisible
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // CONFIRM PASSWORD
                          CommonInput(
                            isVisible: _isPasswordVisible,
                            controller: _confirmPasswordController,
                            hintText: "Confirm password",
                            prefixWidget: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                FontAwesomeIcons.check,
                                size: ICON_SIZE,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // REGISTER BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: CommonElevatedButton(
                              buttonChild: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: mainOrange,
                                    )
                                  : const Text(
                                      "Register",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                              onPress: onRegisterBtnClicked,
                              backgroundColor: buttonBackgroundColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // BACKGROUND AND PROFILE PICS
  Widget _backgroundPicWidget() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // BACKGROUND IMAGE CONTAINER
        InkWell(
          onTap: () => _pickImageDialog(true),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              color: darkBlue,
            ),

            // BACKGROUND IMAGE
            child: _backgroundPic != null
                ? Image(
                    fit: BoxFit.fill,
                    image: MemoryImage(_backgroundPic!),
                  )
                : CommonNetworkImage(
                    imageUrl: _backgroundPremadePic!,
                  ),
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
      ],
    );
  }

  Widget _profilePicWidget() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () => _pickImageDialog(false),
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
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 100,
                decoration: BoxDecoration(
                  color: mainGrey,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  // PROFILE IMAGE
                  child: _profilePic != null
                      ? Image(
                          image: MemoryImage(_profilePic!),
                        )
                      : CommonNetworkImage(
                          boxFit: BoxFit.fill,
                          imageUrl: _profilePremadePic!,
                        ),
                ),
              ),
            ),
          ),
        ),
        // ADD ICON
        Positioned(
          bottom: 0,
          right: 0,
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
                color: mainOrange, borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ],
    );
  }

  Widget backgroundProfilePicWidgets() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // BACKGROUND PIC
        _backgroundPicWidget(),
        // BACK BUTTON
        Positioned(
            top: 5,
            left: 5,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: darkBlue,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
        // PROFILE PIC
        Positioned(
          bottom: -70,
          child: _profilePicWidget(),
        )
      ],
    );
  }
}
