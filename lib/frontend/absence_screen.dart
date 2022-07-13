import 'package:desemar_app/backend/class_data/api/absence_response.dart';
import 'package:desemar_app/backend/class_data/auth_class.dart';
import 'package:desemar_app/backend/functions/dialog_functions.dart';
import 'package:desemar_app/backend/functions/route_functions.dart';
import 'package:desemar_app/backend/functions/services_api/absence_services.dart';
import 'package:desemar_app/backend/functions/shared_preferences.dart';
import 'package:desemar_app/backend/variables/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsenceScreen extends StatefulWidget {
  const AbsenceScreen({Key? key}) : super(key: key);

  @override
  State<AbsenceScreen> createState() => _AbsenceScreenState();
}

class _AbsenceScreenState extends State<AbsenceScreen> {
  AuthClass? authClass;

  TextEditingController nameController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime dateTime = DateTime.now();

  int? recapAbsenceId;
  int presentCount = 0;

  bool isRecapReady = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      dateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
    });

    initLoad();
  }

  void initLoad() async {
    await SPrefs().readAuth().then((auth) async {
      if(auth != null && auth.idPegawai != null) {
        setState(() {
          authClass = auth;

          nameController.text = auth.namaPegawai ?? '';
          nipController.text = auth.nik ?? '';
          positionController.text = auth.jabatan ?? '';
        });

        await AbsenceServices().readAbsenceByNIK(auth.nik!, DateFormat('MMyyyy').format(DateTime.now())).then((dioResult) async {
          AbsenceResponse? absenceResponse = dioResult;

          if(absenceResponse != null && absenceResponse.data != null && absenceResponse.data!.isNotEmpty) {
            setState(() {
              isRecapReady = true;

              recapAbsenceId = int.parse(absenceResponse.data![0].idKehadiran!);
              presentCount = int.parse(absenceResponse.data![0].hadir!);
            });

            await AbsenceServices().readAbsenceByDate(auth.idPegawai!, DateTime.now()).then((readResult) {
              if(readResult != null && readResult.data != null && readResult.data!.isNotEmpty) {
                DialogFunctions(context: context, message: 'Anda sudah melakukan absensi hari ini').okDialog(() {
                  RouteFunctions(context: context).backOffScreen(null);
                });
              }
            });
          }
        });
      }
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
                        readOnly: true,
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
                        readOnly: true,
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
                        readOnly: true,
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
                        onPressed: () async {
                          DialogFunctions(context: context, message: 'Simpan absensi, Anda yakin?').optionDialog(() async {
                            if(isRecapReady) {
                              await AbsenceServices().updateRecapAbsence(recapAbsenceId!, presentCount + 1).then((dioResult) async {
                                if(dioResult) {
                                  await AbsenceServices().writeAbsence(
                                    DateTime.now(),
                                    AuthClass(
                                      idPegawai: authClass!.idPegawai,
                                    ),
                                  ).then((writeResult) {
                                    if(writeResult) {
                                      RouteFunctions(context: context).backOffScreen(true);
                                    }
                                  });
                                }
                              });
                            } else {
                              await AbsenceServices().writeRecapAbsence(
                                DateTime.now(),
                                AuthClass(
                                  nik: authClass!.nik,
                                  namaPegawai: authClass!.namaPegawai,
                                  jenisKelamin: authClass!.jenisKelamin,
                                  jabatan: authClass!.jabatan,
                                ),
                                1,
                              ).then((dioResult) async {
                                if(dioResult) {
                                  await AbsenceServices().writeAbsence(
                                    DateTime.now(),
                                    AuthClass(
                                      idPegawai: authClass!.idPegawai,
                                    ),
                                  ).then((writeResult) {
                                    if(writeResult) {
                                      RouteFunctions(context: context).backOffScreen(true);
                                    }
                                  });
                                }
                              });
                            }
                          }, () {

                          });
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