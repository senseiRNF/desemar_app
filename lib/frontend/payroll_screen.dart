import 'package:desemar_app/backend/class_data/payroll_class.dart';
import 'package:desemar_app/backend/variables/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({Key? key}) : super(key: key);

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  List<PayrollClass> payrollList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      payrollList = [
        PayrollClass(
          name: 'User #1',
          position: 'Position #1',
          date: DateTime(2022, 06, 28),
          mainPayroll: 3000000,
          transportPayroll: 200000,
          lunchPayroll: 500000,
        ),
        PayrollClass(
          name: 'User #2',
          position: 'Position #2',
          date: DateTime(2022, 06, 29),
          mainPayroll: 3200000,
          transportPayroll: 210000,
          lunchPayroll: 500000,
        ),
        PayrollClass(
          name: 'User #3',
          position: 'Position #3',
          date: DateTime(2022, 06, 30),
          mainPayroll: 3400000,
          transportPayroll: 220000,
          lunchPayroll: 500000,
        ),
      ];
    });
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
                          ": ${payrollList[index].name ?? 'User'}",
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
                          ": ${payrollList[index].position ?? 'Jabatan Admin'}",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Tanggal',
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          ": ${DateFormat('dd-MM-yyyy').format(payrollList[index].date!)}",
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
                          ': Rp.${NumberFormat('#,###', 'en_ID').format(payrollList[index].mainPayroll ?? 0).replaceAll(',', '.')},-',
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
                          ': Rp.${NumberFormat('#,###', 'en_ID').format(payrollList[index].transportPayroll ?? 0).replaceAll(',', '.')},-',
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
                          ': Rp.${NumberFormat('#,###', 'en_ID').format(payrollList[index].lunchPayroll ?? 0).replaceAll(',', '.')},-',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {

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