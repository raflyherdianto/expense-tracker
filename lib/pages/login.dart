import 'package:flutter/material.dart';
import 'package:expense_tracker/database/db_helper.dart';
import 'package:expense_tracker/pages/home.dart';
import 'package:quickalert/quickalert.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var db = DBHelper();

  Future initDB() async {
    await db.setDB();
  }

  @override
  void initState() {
    super.initState();

    initDB();
  }

  login() async {
    var res = await db.getLogin(
      usernameInput.text.toString(),
      passwordInput.text.toString(),
    );

    if (res.isNotEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Login Berhasil!',
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
        title: 'Login Gagal!',
        text: 'Username atau Password salah',
      );
    }
  }

  void _setLogin() {
    if (formKey.currentState!.validate()) {
      login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Flexible(
            child: Form(
              key: formKey,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Image(
                        image: AssetImage('assets/icons/logo.png'),
                        width: 200,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Expense Tracker',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // Form Input
                      TextFormField(
                        controller: usernameInput,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username wajib diisi!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Username...',
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          focusColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordInput,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Password...',
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          focusColor: Colors.blue,
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: _setLogin,
                        // onPressed: () {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const Home(),
                        //     ),
                        //   );
                        // },
                        child: const Text('Login',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
