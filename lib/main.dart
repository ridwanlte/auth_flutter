import 'package:auth_flutter/screens/login_page.dart';
import 'package:auth_flutter/splash_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Auth Flutter',
    theme: ThemeData.light().copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: primaryColor
    ),
    home: LoginPage(),
  ));
}
