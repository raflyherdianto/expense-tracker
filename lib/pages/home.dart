import 'package:flutter/material.dart';
import 'package:expense_tracker/pages/cashflow_data.dart';
import 'package:expense_tracker/pages/income.dart';
import 'package:expense_tracker/pages/settings.dart';
import 'package:expense_tracker/pages/expense.dart';
import 'package:expense_tracker/database/db_helper.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var db = DBHelper();
  var formatCurrency = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.confirm,
              title: 'Yakin Logout?',
              confirmBtnText: 'Ya',
              cancelBtnText: 'Tidak',
              confirmBtnColor: Colors.green,
              onConfirmBtnTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
            );
          },
          child: const Text('Logout',
              style: TextStyle(
                color: Colors.white,
              )),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            textStyle: const TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            minimumSize: const Size.fromHeight(50),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Flexible(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Catatan Cashflow',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: db.getTotalCashByType('Pemasukan'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }

                      var data = snapshot.data;

                      return snapshot.hasData
                          ? Text(
                              "Pemasukan   : " + formatCurrency.format(data),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                color: Colors.green,
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Rp. 0',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            );
                    },
                  ),
                  FutureBuilder(
                    future: db.getTotalCashByType('Pengeluaran'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }

                      var data = snapshot.data;

                      return snapshot.hasData
                          ? Text(
                              "Pengeluaran : " + formatCurrency.format(data),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                color: Colors.red,
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Rp. 0',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Image(
                      image: Image.asset('assets/icons/graph.png').image,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Income(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: const [
                                  Image(
                                    image:
                                        AssetImage('assets/icons/income.png'),
                                    width: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tambah\nPemasukan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Expense(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: const [
                                  Image(
                                    image:
                                        AssetImage('assets/icons/expense.png'),
                                    width: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tambah\nPengeluaran',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CashflowData(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: const [
                                  Image(
                                    image:
                                        AssetImage('assets/icons/cashflow.png'),
                                    width: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Detail\nCashflow',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Settings(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: const [
                                  Image(
                                    image:
                                        AssetImage('assets/icons/settings.png'),
                                    width: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Pengaturan\n',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
