import 'package:nucore_project/core/utils/api_paths.dart';
import 'package:nucore_project/core/utils/my_dio.dart';
import 'package:nucore_project/data/models/login_response_model.dart';
import 'package:nucore_project/presentation/widgets/custom_snackbar.dart';

abstract class AuthRepository {
  static Future<dynamic> login(Map<String, dynamic> data) async {
    dynamic resp = await MyDio().post(path: ApiPaths.login, data: data);

    if (resp is Map<String, dynamic> && resp['success'] == true) {
      CustomSnackbar.successSnackbar(resp['message']);
      return LoginResponse.fromJson(resp);
    }
  }
}
