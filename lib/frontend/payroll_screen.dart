import 'dart:io';

import 'package:desemar_app/backend/functions/dialog_functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:desemar_app/backend/class_data/api/honor_response.dart';
import 'package:desemar_app/backend/functions/services_api/honor_services.dart';
import 'package:desemar_app/backend/functions/shared_preferences.dart';
import 'package:desemar_app/backend/variables/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({Key? key}) : super(key: key);

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  List<HonorResponseData> payrollList = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SPrefs().readAuth().then((auth) async {
      if(auth != null && auth.idPegawai != null) {
        await HonorServices().readHonorByUser(auth.idPegawai!).then((dioResult) {
          List<HonorResponseData> listTemp = [];

          if(dioResult != null && dioResult.data != null) {
            for(int i = 0; i < dioResult.data!.length; i++) {
              listTemp.add(dioResult.data![i]);
            }

            setState(() {
              payrollList = listTemp;
            });
          }
        });
      }
    });
  }

  void generatePDF(HonorResponseData dataResponse) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                'Slip Gaji',
                style: pw.TextStyle(
                  fontSize: 20.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Divider(),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Text(
                "Nama: ${dataResponse.namaPegawai!}",
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.Text(
                "Jabatan: ${dataResponse.namaJabatan!}",
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.Text(
                "Bulan: ${dataResponse.bulan!}",
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.Text(
                "Gaji Pokok: Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(dataResponse.gajiPokok!))}",
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.Text(
                "Transport: Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(dataResponse.tjTransport!))}",
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.Text(
                "Uang Makan: Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(dataResponse.uangMakan!))}",
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
            ],
          );
        },
      ),
    );

    var status = await Permission.storage.status;

    if(status.isGranted) {
      final directory = Directory('/storage/emulated/0/Download');

      final file = File("${directory.path}/slip_gaji.pdf");

      await file.writeAsBytes(await pdf.save()).then((result) {
        DialogFunctions(context: context, message: 'Slip gaji berhasil di unduh').okDialog(() {

        });
      });
    } else {
      await Permission.storage.request().then((permissionResult) async {
        if(permissionResult.isGranted) {
          final directory = (await getApplicationDocumentsDirectory()).path;

          final file = File("$directory/example.pdf");
          await file.writeAsBytes(await pdf.save()).then((result) {
            DialogFunctions(context: context, message: 'Sertifikat berhasil di unduh').okDialog(() {

            });
          });
        } else {
          DialogFunctions(context: context, message: 'Tidak dapat melanjutkan, diperlukan izin untuk mengakses penyimpanan').okDialog(() {

          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Data Gaji',
        ),
      ),
      body: ListView.builder(
        itemCount: payrollList.length,
        itemBuilder: (BuildContext listContext, int index) {
          return Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0,),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Nama',
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          ": ${payrollList[index].namaPegawai ?? 'User'}",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Jabatan',
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          ": ${payrollList[index].namaJabatan ?? 'Jabatan Admin'}",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Bulan',
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          ": ${payrollList[index].bulan ?? 'Bulan'}",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Gaji Pokok',
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          ': Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(payrollList[index].gajiPokok ?? '0')).replaceAll(',', '.')},-',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Tunjangan Transport',
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          ': Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(payrollList[index].tjTransport ?? '0')).replaceAll(',', '.')},-',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Uang Makan',
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          ': Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(payrollList[index].uangMakan ?? '0')).replaceAll(',', '.')},-',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      DialogFunctions(context: context, message: 'Mengunduh laporan menjadi PDF, Anda yakin?').optionDialog(() {
                        generatePDF(payrollList[index]);
                      }, () {

                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: GlobalColor.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0,),
                      child: Text(
                        'Cetak Slip Gaji',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}