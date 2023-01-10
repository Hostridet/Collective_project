import 'package:collective_project/user_interface/components/RegisterButtonWidget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/register_bloc/register_bloc.dart';
import '../../repository/AuthRepository.dart';
import '../components/InputFieldWidget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode nameFocus;
  late FocusNode surnameFocus;
  late FocusNode patronymicFocus;
  late FocusNode emailFocus;
  late FocusNode registrationBtnFocus;

  late TextEditingController userName;
  late TextEditingController password;
  late TextEditingController name;
  late TextEditingController surname;
  late TextEditingController patronymic;
  late TextEditingController email;

  @override
  void initState() {
    super.initState();
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    registrationBtnFocus = FocusNode();
    nameFocus = FocusNode();
    surnameFocus = FocusNode();
    patronymicFocus = FocusNode();
    emailFocus = FocusNode();

    userName = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    surname = TextEditingController();
    patronymic = TextEditingController();
    email = TextEditingController();
  }
  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    nameFocus.dispose();
    surnameFocus.dispose();
    patronymicFocus.dispose();
    emailFocus.dispose();
    registrationBtnFocus.dispose();
    userName.dispose();
    password.dispose();
    name.dispose();
    surname.dispose();
    patronymic.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed('/');
          },
        ),
        title: const Text('Регистрация'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            RepositoryProvider.of<AuthRepository>(context),
          ),
          child: BlocConsumer<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return buildInitialInput();
            },
            listener: (context, state) {
              if (state is RegisterEmptyError) {
                buildErrorLayout("Все поля должны быть заполнены");
              }
              if (state is RegisterEmailError) {
                buildErrorLayout("Неверно введена электронная почта");
              }
              if (state is RegisterBusyError) {
                buildErrorLayout("Пользователь с таким логином уже существует");
              }
              if (state is RegisterLoadedState) {
                Navigator.of(context)
                    .pushReplacementNamed('/');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 20),
        InputField(
          focusNode: usernameFocus,
          textController: userName,
          label: "Логин",
          icons: const Icon(Icons.person, color: Colors.green),
        ),
        const SizedBox(height: 10),
        InputField(
          focusNode: passwordFocus,
          textController: password,
          label: "Пароль",
          icons: const Icon(Icons.lock, color: Colors.green),
        ),
        const SizedBox(height: 10),
        InputField(
          focusNode: nameFocus,
          textController: name,
          label: "Имя",
          icons: const Icon(Icons.supervised_user_circle, color: Colors.green),
        ),
        const SizedBox(height: 10),
        InputField(
          focusNode: surnameFocus,
          textController: surname,
          label: "Фамилия",
          icons: const Icon(Icons.supervised_user_circle, color: Colors.green),
        ),
        const SizedBox(height: 10),
        InputField(
          focusNode: patronymicFocus,
          textController: patronymic,
          label: "Отчество",
          icons: const Icon(Icons.supervised_user_circle, color: Colors.green),
        ),
        const SizedBox(height: 10),
        InputField(
          focusNode: emailFocus,
          textController: email,
          label: "Электронная почта",
          icons: const Icon(Icons.supervised_user_circle, color: Colors.green),
        ),
        const SizedBox(height: 10),
        RegisterButton(
            focusNode: registrationBtnFocus,
            userName: userName,
            password: password,
            name: name,
            surname: surname,
            patronymic: patronymic,
            email: email
        ),
      ],
    ),
  );

  ScaffoldFeatureController buildErrorLayout(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
}
