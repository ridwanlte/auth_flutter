import 'package:auth_flutter/constants.dart';
import 'package:auth_flutter/network/session_manager.dart';
import 'package:auth_flutter/screens/home_page.dart';
import 'package:auth_flutter/screens/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void onSession() async {
    Future.delayed(defaultDuration, () {
      sessionManager.getPref().then((value) {
        if (value == null || value == false) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => Homepage()), (route) => false);
        }
      });
    });
  }

  @override
  void initState() {
    onSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/logo_app.png')),
    );
  }
}
