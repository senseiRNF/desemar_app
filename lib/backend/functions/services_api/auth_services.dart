import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:desemar_app/backend/class_data/api/auth_response.dart';
import 'package:desemar_app/backend/class_data/auth_class.dart';
import 'package:desemar_app/backend/functions/services_api/init_services.dart';
import 'package:desemar_app/backend/functions/shared_preferences.dart';
import 'package:dio/dio.dart';

class AuthServices {
  Future<bool> loginUser(String username, String password) async {
    bool result = false;

    String generateMD5() {
      return md5.convert(utf8.encode(password)).toString();
    }

    FormData formData = FormData.fromMap({
      'username': username,
      'pass': generateMD5(),
    });

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.post(
          'read-login-user.php',
          data: formData,
        ).then((dioResult) async {
          AuthResponse authResponse = AuthResponse.fromJson(dioResult.data);

          if(authResponse.data != null && authResponse.data!.isNotEmpty) {
            await SPrefs().writeAuth(
              AuthClass(
                idPegawai: int.parse(authResponse.data![0].idPegawai!),
                nik: authResponse.data![0].nik,
                namaPegawai: authResponse.data![0].namaPegawai,
                username: authResponse.data![0].username,
                password: authResponse.data![0].password,
                jenisKelamin: authResponse.data![0].jenisKelamin,
                jabatan: authResponse.data![0].jabatan,
                tanggalMasuk: DateTime.parse(authResponse.data![0].tanggalMasuk!),
                status: authResponse.data![0].status,
                photo: authResponse.data![0].photo,
                hakAkses: int.parse(authResponse.data![0].hakAkses!),
              ),
            ).then((writeResult) {
              if(writeResult) {
                result = true;
              }
            });
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}