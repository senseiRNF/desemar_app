import 'package:desemar_app/backend/functions/route_functions.dart';
import 'package:desemar_app/backend/variables/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsenceScreen extends StatefulWidget {
  const AbsenceScreen({Key? key}) : super(key: key);

  @override
  State<AbsenceScreen> createState() => _AbsenceScreenState();
}

class _AbsenceScreenState extends State<AbsenceScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    setState(() {
      dateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Absensi Karyawan',
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0,),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0,),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        'ABSENSI KARYAWAN',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            'Nama Karyawan',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: nipController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            'Nomor Induk Karyawan',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: positionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            'Jabatan',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: dateTime,
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2032),
                          ).then((result) {
                            if(result != null) {
                              setState(() {
                                dateTime = result;

                                dateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
                              });
                            }
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            'Tanggal',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          RouteFunctions(context: context).backOffScreen(null);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: GlobalColor.primary,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0,),
                          child: Text(
                            'Simpan',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}