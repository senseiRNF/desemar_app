import 'package:desemar_app/backend/class_data/api/honor_response.dart';
import 'package:desemar_app/backend/functions/services_api/init_services.dart';
import 'package:dio/dio.dart';

class HonorServices {
  Future<HonorResponse?> readHonorByUser(int id) async {
    HonorResponse? result;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          'read-honor-by-user.php',
          queryParameters: {
            'id': id,
          },
        ).then((dioResult) {
          result = HonorResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}