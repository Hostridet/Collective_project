import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class AuthRepository {
  Future<bool> getAuth(String userName, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (userName == "user" && password == "user") {
      return true;
    }
    else {
      return false;
    }
  }

  Future<void> register(String login, String password, String name, String surname, String patronymic, String email) async {

  }
}