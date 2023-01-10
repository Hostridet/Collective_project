import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class AuthRepository {
  Future<bool> getAuth(String userName, String password) async {
    final prefs = await SharedPreferences.getInstance();
    int index = 0;
    bool flag = false;
    bool isLogin = false;
    while (flag == false) {
      if (prefs.getString('user${index.toString()}') != null) {
        String user = await prefs.getString('user${index.toString()}')!;
        if (user.split("/")[1] == userName && user.split("/")[2] == password) {
          isLogin = true;
        }
        index++;
      }
      else {
        flag = true;
      }
    }
    return isLogin;
  }

  Future<void> register(String login, String password, String name, String surname, String patronymic, String email) async {
    final prefs = await SharedPreferences.getInstance();
    int id = await User.getId();
    User user = User(
        id: id,
        login: login,
        password: password,
        name: name,
        surname: surname,
        patronymic: patronymic,
        email: email
    );
    user.save();
  }
  Future<bool> checkLogin(String login) async {
    final prefs = await SharedPreferences.getInstance();
    int index = 0;
    bool flag = false;
    bool isLogin = false;
    while (flag == false) {
      if (prefs.getString('user${index.toString()}') != null) {
        String user = await prefs.getString('user${index.toString()}')!;
        if (user.split("/")[1] == login) {
          isLogin = true;
        }
        index++;
      }
      else {
        flag = true;
      }
    }
    return isLogin;
  }
}