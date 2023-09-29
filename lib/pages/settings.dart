import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import 'package:quickalert/quickalert.dart';
import 'package:expense_tracker/pages/home.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final formKey = GlobalKey<FormState>();

  TextEditingController passwordInput = TextEditingController();
  TextEditingController confirmPasswordInput = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var db = DBHelper();

  updatePassword() async {
    var res = await db.getPassword();

    if (passwordInput.text.toString() == res.toString()) {
      await db.updatePassword(confirmPasswordInput.text.toString());

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Password berhasil diubah!',
        onConfirmBtnTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        },
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Password gagal diubah!',
        text: 'Password saat ini salah',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    updatePassword();
                  }
                },
                child: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          )),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Flexible(
            child: Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pengaturan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password Saat Ini :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password saat ini wajib diisi!';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: passwordInput,
                      decoration: const InputDecoration(
                        labelText: 'Masukkan Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.green,
                        ),
                        focusColor: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Password Baru :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password baru wajib diisi!';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: confirmPasswordInput,
                      decoration: const InputDecoration(
                        labelText: 'Masukkan Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.green,
                        ),
                        focusColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
