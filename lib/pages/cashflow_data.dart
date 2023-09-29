// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/cashflow.dart';
import 'package:expense_tracker/database/db_helper.dart';
import 'package:expense_tracker/pages/cashflow.dart';
import 'package:expense_tracker/pages/home.dart';
import 'package:quickalert/quickalert.dart';

class CashflowData extends StatefulWidget {
  const CashflowData({Key? key}) : super(key: key);

  @override
  State<CashflowData> createState() => _CashflowDataState();
}

class _CashflowDataState extends State<CashflowData> {
  var db = DBHelper();

  deleteAll() async {
    var res = await db.getCashflow();

    if (res.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Data kosong!',
        text: 'Tidak ada data yang bisa dihapus',
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: 'Hapus semua data?',
        text: 'Semua data akan dihapus',
        onCancelBtnTap: () {
          Navigator.pop(context);
        },
        onConfirmBtnTap: () async {
          await db.deleteAllCashflow();

          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Data berhasil dihapus!',
            onConfirmBtnTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CashflowData(),
                ),
              );
            },
          );
        },
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
                deleteAll();
              },
              child: const Text('Hapus data',
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
              child: const Text('Kembali',
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
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Flexible(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detail Cashflow',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: db.getCashflow(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }

                        var data = snapshot.data;

                        return snapshot.hasData
                            ? CashflowPage(data as List<Cashflow>)
                            : const Center(
                                child: Text(
                                  'No Data',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
