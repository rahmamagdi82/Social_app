import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';


ThemeData lightTheme()=>ThemeData(
  fontFamily: 'jannah',
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.3,
    ),
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    // headline6: TextStyle(
    //     fontSize: 20.0,
    //     fontWeight: FontWeight.normal,
    //     color: Colors.black,
    // ),
  ),
  primarySwatch: defultColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.lightGreen,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 25.0,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      fontFamily: 'jannah',
      fontSize: 30.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0,
    ),
    backgroundColor: Colors.white,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
);

ThemeData darkTheme()=>ThemeData(
  fontFamily: 'jannah',
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3,
    ),
    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),
  //   headline6: TextStyle(
  //       fontSize: 20.0,
  //       color: Colors.white
  //   ),
  ),
  primarySwatch: defultColor,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    selectedItemColor: Colors.lightGreen,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 25.0,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme:  AppBarTheme(
    titleSpacing: 20.0,
    titleTextStyle: const TextStyle(
      fontFamily: 'jannah',
      fontSize: 30.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 30.0,
    ),
    backgroundColor: HexColor('333739'),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
);