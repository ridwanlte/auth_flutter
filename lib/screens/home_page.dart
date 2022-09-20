import 'package:auth_flutter/constants.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          child: Text(
            'Welcome to Home Page',
            style: TextStyle(color: bodyTextColor, fontSize: 32),
          ),
        ),
      )),
    );
  }
}
