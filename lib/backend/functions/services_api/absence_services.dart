import 'package:desemar_app/backend/class_data/api/absence_response.dart';
import 'package:desemar_app/backend/functions/services_api/init_services.dart';
import 'package:dio/dio.dart';

class AbsenceServices {
  Future<AbsenceResponse?> readAbsenceByNIK(String nik) async {
    AbsenceResponse? result;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          'read-absence-by-nik.php',
          queryParameters: {
            'nik': nik,
          },
        ).then((dioResult) {
          result = AbsenceResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}