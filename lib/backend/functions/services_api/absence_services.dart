import 'package:desemar_app/backend/class_data/api/absence_response.dart';
import 'package:desemar_app/backend/class_data/auth_class.dart';
import 'package:desemar_app/backend/functions/services_api/init_services.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class AbsenceServices {
  Future<AbsenceResponse?> readAbsenceByNIK(String nik, String month) async {
    AbsenceResponse? result;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          'read-absence-by-nik.php',
          queryParameters: {
            'nik': nik,
            'month': month,
          },
        ).then((dioResult) {
          result = AbsenceResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<AbsenceResponse?> readAbsenceByDate(int userId, DateTime date) async {
    AbsenceResponse? result;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          'read-absence-by-date.php',
          queryParameters: {
            'id': userId,
            'tanggal': DateFormat('yyyy-MM-dd').format(date),
          },
        ).then((dioResult) {
          result = AbsenceResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<bool> writeRecapAbsence(DateTime date, AuthClass auth, int presentCount) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'bulan': DateFormat('MMyyyy').format(date),
      'nik': auth.nik,
      'nama_pegawai': auth.namaPegawai,
      'jenis_kelamin': auth.jenisKelamin,
      'nama_jabatan': auth.jabatan,
      'hadir': presentCount,
      'sakit': '0',
      'alpha': '0',
    });

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.post(
          'write-recap-absence.php',
          data: formData,
        ).then((dioResult) {
          if(dioResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<bool> writeAbsence(DateTime date, AuthClass auth) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'id_pegawai': auth.idPegawai,
      'tanggal': DateFormat('yyyy-MM-dd').format(date),
      'status_absen': 'hadir',
    });

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.post(
          'write-absence.php',
          data: formData,
        ).then((dioResult) {
          if(dioResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<bool> updateRecapAbsence(int id, int presentCount) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'id': id,
      'hadir': presentCount,
    });

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.post(
          'update-recap-absence.php',
          data: formData,
        ).then((dioResult) {
          if(dioResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}