

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/register_bloc/register_bloc.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton(
      {Key? key,
        required this.focusNode,
        required this.userName,
        required this.password,
        required this.name,
        required this.surname,
        required this.patronymic,
        required this.email,
      })
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController userName;
  final TextEditingController password;
  late TextEditingController name;
  late TextEditingController surname;
  late TextEditingController patronymic;
  late TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.00),
      child: OutlinedButton(
        focusNode: focusNode,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green, width: 1),
            minimumSize: const Size(double.infinity, 54),
            backgroundColor:  Colors.green),
        onPressed: () {
          BlocProvider.of<RegisterBloc>(context)
              .add(RegisterAddEvent(userName.text, password.text, name.text, surname.text, patronymic.text, email.text));
        },
        child: const Text(
          'Зарегистрироваться',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}