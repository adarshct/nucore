import 'package:get_storage/get_storage.dart';

abstract class LocalStorage {
  static Future<void> setData(
      {required String key, required dynamic value}) async {
    await GetStorage().write(key, value);
  }

  static dynamic getData({required String key}) {
    return GetStorage().read(key);
  }

  static Future<void> clearData() async {
    await GetStorage().erase();
  }
}
