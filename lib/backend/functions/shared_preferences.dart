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
          auth.userId!.toString(),
          auth.username!,
          auth.name!,
          auth.nip!,
          auth.position!,
          auth.workUnit!
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
          userId: int.parse(sPrefList![0]),
          username: sPrefList![1],
          name: sPrefList![2],
          nip: sPrefList![3],
          position: sPrefList![4],
          workUnit: sPrefList![5],
        );
      }
    });

    return auth;
  }
}