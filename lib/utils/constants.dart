// IMAGES
// ignore_for_file: constant_identifier_names

import 'package:anihub_flutter/screens/home/discuss_screen.dart';
import 'package:anihub_flutter/screens/home/home_screen.dart';
import 'package:anihub_flutter/screens/home/profile_screen.dart';
import 'package:anihub_flutter/screens/home/search_screen.dart';
import 'package:flutter/material.dart';

const appLogoAbsolutePath = 'assets/images/app_logo.jpg';
const googleLogoAbsolutePath = "assets/images/google_logo.png";

// DEFAULT PROFILE PIC URL
const defaultProfilePicUrl =
    'https://firebasestorage.googleapis.com/v0/b/anihub-8a877.appspot.com/o/pre-mades%2FprofilePics%2Fdefault_profile_pic.jpg?alt=media&token=70a6442b-1b68-4ba8-a3b2-42baf04e5700';

// DEFAULT BACKGROUND PIC URL

// PROFILE PICS
const profilePics = [
  "https://firebasestorage.googleapis.com/v0/b/anihub-8a877.appspot.com/o/pre-mades%2FprofilePics%2Fdemon_slayer_1.jpg?alt=media&token=133938f2-6729-47ca-84fb-9a6fef2b2a48",
  "https://firebasestorage.googleapis.com/v0/b/anihub-8a877.appspot.com/o/pre-mades%2FprofilePics%2Fdemon_slayer_2.jpg?alt=media&token=4363ccb7-65a7-4396-8e3e-8ca19a0bcdb9",
  "https://firebasestorage.googleapis.com/v0/b/anihub-8a877.appspot.com/o/pre-mades%2FprofilePics%2F3.jpg?alt=media&token=5436f315-a58e-42e0-85f8-d463cd11cb4b",
  "https://firebasestorage.googleapis.com/v0/b/anihub-8a877.appspot.com/o/pre-mades%2FprofilePics%2Fmy_hero_academia.jpg?alt=media&token=5d95d162-2887-4eb4-a14e-30163fcba35e",
  "https://firebasestorage.googleapis.com/v0/b/anihub-8a877.appspot.com/o/pre-mades%2FprofilePics%2Ftokyo_ghoul.jpg?alt=media&token=7486f895-a965-4e13-94aa-473831c5aaac",
];
// BACKGROUND PICS
const backgroundPics = [
  "https://firebasestorage.googleapis.com/v0/b/anihub-8a877.appspot.com/o/pre-mades%2FbackgroundPics%2Fdemon_slayer_1.jpg?alt=media&token=485105ba-08f7-4513-85c4-d1f16754a83a",
  "https://firebasestorage.googleapis.com/v0/b/anihub-8a877.appspot.com/o/pre-mades%2FbackgroundPics%2Flandscape.jpg?alt=media&token=66f8c2b8-3347-4ab4-b702-6eb4c93d0f18",
  "https://firebasestorage.googleapis.com/v0/b/anihub-8a877.appspot.com/o/pre-mades%2FbackgroundPics%2Ftokyo_ghoul.jpg?alt=media&token=3f201fae-17a7-4f68-a5ab-b10fc780667f",
];

// ICON SIZE
const double ICON_SIZE = 26;

// SUCCESS STRING RESULT FOR FIREBASE FUNCTIONS
const String SUCCESS_VALUE = "Success";

const String FAIL_VALUE = "Some error occurred";

// MAIN SCREEN LIST OF SCREENS
const List<Widget> MAIN_SCREENS = [
  // FIRST PAGE
  HomeScreen(),
  // SECOND PAGE
  SearchScreen(),
  // THIRD PAGE
  DiscussScreen(),
  // FOURTH PAGE
  ProfileScreen(),
];

const LinearGradient mainScreenBackground = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromARGB(47, 2, 163, 221),
    Color.fromARGB(12, 0, 74, 203),
  ],
);

const SEARCH_SCREEN_MAIN_TEXT = "What are you looking for?";
const SEARCH_SCREEN_SECONDARY_TEXT =
    "Find your favorite anime between more than 10,000 animes";
