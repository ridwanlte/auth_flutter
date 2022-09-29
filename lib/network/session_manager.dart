import 'package:auth_flutter/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  String? nUserNama, nUserEmail, nId, nToken;

  void savePref(String? nId, String? nUserNama, String? nUserEmail,
      String? nToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', nUserEmail ?? '');
    pref.setString('usernama', nUserNama ?? '');
    pref.setString('Id', nId ?? '');
    pref.setString('token', nToken ?? '');
  }

  Future getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nToken = pref.getString('token');
    nUserNama = pref.getString('usernama');
    nUserEmail = pref.getString('email');
    nId = pref.getString('id');
    return nToken;
  }

  //for clear data when logout
  void clearSession(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
  }
}

final sessionManager = SessionManager();
