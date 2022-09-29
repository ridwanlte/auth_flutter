import 'package:auth_flutter/constants.dart';
import 'package:auth_flutter/network/session_manager.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? userId, userNama, userEmail, token;

  @override
  void initState() {
    sessionManager.getPref().then((value) {
      setState(() {
        userId = sessionManager.nId;
        userNama = sessionManager.nUserNama;
        userEmail = sessionManager.nUserEmail;
        token = sessionManager.nToken;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () {
                sessionManager.clearSession(context);
              },
              icon: Icon(Icons.lock))
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Container(
          child: Column(
            children: [
              Text(
                '${userEmail}',
                style: TextStyle(color: bodyTextColor, fontSize: 18),
              ),
              Text(
                'Welcome to Home Page',
                style: TextStyle(color: bodyTextColor, fontSize: 32),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
