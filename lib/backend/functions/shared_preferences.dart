import 'package:desemar_app/backend/class_data/auth_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPrefs {
  Future<SharedPreferences> init() async {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();

    return sPrefs;
  }

  Future<bool> writeAuth(AuthClass auth) async {
    bool result = false;

    await init().then((sPrefs) async {
      await sPrefs.setStringList(
        'auth',
        [
          '${auth.idPegawai!}',
          auth.nik!,
          auth.namaPegawai!,
          auth.username!,
          auth.password!,
          auth.jenisKelamin!,
          auth.jabatan!,
          '${auth.tanggalMasuk!}',
          auth.status!,
          auth.photo!,
          '${auth.hakAkses!}',
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<AuthClass?> readAuth() async {
    AuthClass? auth;
    List<String>? sPrefList;

    await init().then((sPrefs) async {
      sPrefList = sPrefs.getStringList('auth');

      if(sPrefList != null && sPrefList!.isNotEmpty) {
        auth = AuthClass(
          idPegawai: int.parse(sPrefList![0]),
          nik: sPrefList![1],
          namaPegawai: sPrefList![2],
          username: sPrefList![3],
          password: sPrefList![4],
          jenisKelamin: sPrefList![5],
          jabatan: sPrefList![6],
          tanggalMasuk: DateTime.parse(sPrefList![7]),
          status: sPrefList![8],
          photo: sPrefList![9],
          hakAkses: int.parse(sPrefList![10]),
        );
      }
    });

    return auth;
  }

  Future<bool> deleteAuth() async {
    bool result = false;

    await init().then((sPrefs) async {
      await sPrefs.remove('auth').then((_) {
        result = true;
      });
    });

    return result;
  }
}