import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  String? nUserNama, nUserEmail, nId;

  void savePref(String? nId, String? nUserNama, String? nUserEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', nUserEmail ?? '');
    pref.setString('usernama', nUserNama ?? '');
    pref.setString('userId', nId ?? '');
  }
}

final sessionManager = SessionManager();