import 'package:flutter/material.dart';
import 'package:tokokita/bloc/registrasi_bloc.dart';
import 'package:tokokita/widget/success_dialog.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.redAccent,
        title: const Text(
          "Registrasi",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.amberAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _namaTextField(),
                _emailTextField(),
                _passwordTextField(),
                _passwordKonfirmasiTextField(),
                _buttonRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: "Nama",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        controller: _namaTextboxController,
        validator: (value) {
          if (value!.length < 3) {
            return "Nama harus diisi minimal 3 karakter";
          }
          return null;
        },
      ),
    );
  }

  Widget _emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        controller: _emailTextboxController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email harus diisi';
          }
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = RegExp(pattern.toString());
          if (!regex.hasMatch(value)) {
            return "Email tidak valid";
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: _passwordTextboxController,
        validator: (value) {
          if (value!.length < 6) {
            return "Password harus diisi minimal 6 karakter";
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordKonfirmasiTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: "Konfirmasi Password",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value) {
          if (value != _passwordTextboxController.text) {
            return "Konfirmasi Password tidak sama";
          }
          return null;
        },
      ),
    );
  }

  Widget _buttonRegistrasi() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submit,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
          color: Colors.white,
        )
            : const Text("Registrasi"),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      RegistrasiBloc.registrasi(
        nama: _namaTextboxController.text,
        email: _emailTextboxController.text,
        password: _passwordTextboxController.text,
      ).then((value) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
            description: "Registrasi berhasil, silahkan login",
            okClick: () {
              Navigator.pop(context);
            },
          ),
        );
      }, onError: (error) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Registrasi gagal, silahkan coba lagi",
          ),
        );
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }
}
