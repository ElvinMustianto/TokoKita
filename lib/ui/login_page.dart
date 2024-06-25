import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokokita/bloc/login_bloc.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/ui/home_page.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emailTextField(),
                _passwordTextField(),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: _buttonLogin()),
                _menuRegistrasi()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      child: Column(children: [
        Card(
          color: Colors.white,
          margin: const EdgeInsets.all(5),
          child: TextFormField(
            decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(fontFamily: "Poppins"),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.redAccent,
                ),
                hintText: "Email...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            keyboardType: TextInputType.text,
            controller: _emailTextboxController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Email harus diisi";
              }
              return null;
            },
          ),
        ),
      ]),
    );
  }

  Widget _passwordTextField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            margin: const EdgeInsets.all(5),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(fontFamily: "Poppins"),
                  prefixIcon: const Icon(
                    Icons.key,
                    color: Colors.redAccent,
                  ),
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: _passwordTextboxController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Password harus diisi";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) _submit();
          }
        },
        style: const ButtonStyle(
          backgroundColor:MaterialStatePropertyAll(Colors.redAccent)
        ),
        child: const Text(
          "LOGIN",
          style: TextStyle(fontFamily: "Poppins"),
        ));
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      await UserInfo().setToken(value.token.toString());
      await UserInfo().setUserID(
          int.parse(value.userID.toString())); // Assuming value.userID is int?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login Gagal, Silakan Coba Lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(color: Colors.blue, fontFamily: "Poppins"),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}
