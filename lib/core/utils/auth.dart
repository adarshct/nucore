import 'package:nucore_project/data/models/login_response_model.dart';

import 'local_storage.dart';

abstract class Auth {
  static String get accessToken => LocalStorage.getData(key: 'access') ?? "";
  static String get isAdmin => LocalStorage.getData(key: 'isAdmin') ?? "";
  static User user = User();

  // static String get refreshToken => LocalStorage.getData(key: 'refresh') ?? "";
}
