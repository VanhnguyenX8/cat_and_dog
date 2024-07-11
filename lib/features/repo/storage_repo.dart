import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageRepo {
  Future<bool?> checkValueOpenFirstApp();
  Future<bool?> setValueOpenFirstApp();
}

class StorageRepoIpml extends StorageRepo {
  @override
  Future<bool?> checkValueOpenFirstApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_intro");
  }

  @override
  Future<bool?> setValueOpenFirstApp() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('is_intro', true);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
