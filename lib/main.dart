import 'package:auth_flutter/screens/home_page.dart';
import 'package:auth_flutter/screens/login_page.dart';
import 'package:auth_flutter/splash_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TES SMK',
    theme: ThemeData.light().copyWith(
        primaryColor: primaryColor,
        errorColor: bodyTextColor,
        scaffoldBackgroundColor: primaryColor),
    home: SplashScreen(),
  ));
}
