import 'package:shared_preferences/shared_preferences.dart';

class User {
  int id;
  String login;
  String password;
  String name;
  String surname;
  String patronymic;
  String email;

  User({
    required this.id,
    required this.login,
    required this.password,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.email,
  });

  void save() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "${id.toString()}/$login/$password/$name/$surname/$patronymic/$email";
    await prefs.setString('user + ${getId()}', savedString);
  }

  static Future<int> getId() async {
    final prefs = await SharedPreferences.getInstance();
    int index = 0;
    bool flag = false;
    while (flag == false) {
      if (prefs.getString('user + ${index.toString()}') != null) {
        index++;
      }
      else {
        flag = false;
      }
    }
    return index;
  }
}
