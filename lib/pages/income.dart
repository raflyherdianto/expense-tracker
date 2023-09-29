// ignore_for_file: no_logic_in_create_state, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/models/cashflow.dart';
import 'package:expense_tracker/database/db_helper.dart';
import 'package:quickalert/quickalert.dart';
import 'package:expense_tracker/pages/home.dart';

class Income extends StatefulWidget {
  const Income({Key? key}) : super(key: key);

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  late Cashflow cashflow;
  final formKey = GlobalKey<FormState>();

  TextEditingController dateInput = TextEditingController();
  TextEditingController cashInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future insertData() async {
    var db = DBHelper();
    var cashflow = Cashflow(
      dateInput.text,
      int.parse(cashInput.text),
      descriptionInput.text,
      'Pemasukan',
    );
    await db.saveCashflow(cashflow);
    print('Data saved!');
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Berhasil disimpan!',
      onConfirmBtnTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      },
    );
  }

  void _saveData() {
    if (formKey.currentState!.validate()) {
      insertData();
    }
  }

  @override
  void dispose() {
    dateInput.dispose();
    cashInput.dispose();
    descriptionInput.dispose();

    super.dispose();
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
                dateInput.clear();
                cashInput.clear();
                descriptionInput.clear();
              },
              child: const Text('Reset', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
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
              onPressed: _saveData,
              child:
                  const Text('Simpan', style: TextStyle(color: Colors.white)),
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
              child:
                  const Text('Kembali', style: TextStyle(color: Colors.white)),
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
                      'Tambah Pemasukan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Tanggal :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(
                      child: Center(
                        child: TextFormField(
                          controller: dateInput,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal wajib diisi!';
                            }
                            return null;
                          },
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                              });
                            } else {}
                          },
                          decoration: const InputDecoration(
                            labelText: "Masukkan Tanggal",
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
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Nominal :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nominal wajib diisi!';
                        }
                        return null;
                      },
                      controller: cashInput,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Masukkan Nominal',
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
                      height: 20,
                    ),
                    const Text(
                      'Keterangan :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Keterangan wajib diisi!';
                        }
                        return null;
                      },
                      controller: descriptionInput,
                      decoration: const InputDecoration(
                        labelText: 'Masukkan Keterangan',
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
