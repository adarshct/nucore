import 'package:nucore_project/core/utils/api_paths.dart';
import 'package:nucore_project/core/utils/my_dio.dart';
import 'package:nucore_project/data/models/login_response_model.dart';
import 'package:nucore_project/data/models/summary_model.dart';
import 'package:nucore_project/presentation/widgets/custom_snackbar.dart';

abstract class AdminRepository {
  static Future<dynamic> getUsers() async {
    dynamic resp = await MyDio().get(path: ApiPaths.users);

    if (resp is Map<String, dynamic> && resp['success']) {
      CustomSnackbar.successSnackbar(resp['message']);
      final list = List.from(resp['data']);

      return list.map((e) => User.fromJson(e)).toList();
    }
  }

  static Future<dynamic> createUser({
    required Map<String, dynamic> data,
    String? id,
  }) async {
    dynamic resp;

    if (id == null) {
      resp = await MyDio().post(path: ApiPaths.users, data: data);
    } else {
      resp = await MyDio().patch(path: ApiPaths.users, id: id, data: data);
    }

    if (resp is Map<String, dynamic> && resp['success'] == true) {
      CustomSnackbar.successSnackbar(resp['message']);
      return true;
    }
  }

  static Future<dynamic> getSummary() async {
    dynamic resp = await MyDio().get(path: ApiPaths.summary);

    if (resp is Map<String, dynamic> && resp['success'] == true) {
      CustomSnackbar.successSnackbar(resp['message']);

      return DashboardResponse.fromJson(resp['data']);
    }
  }

  static Future<dynamic> getRevenue() async {
    dynamic resp = await MyDio().get(path: ApiPaths.revenue);

    if (resp is Map<String, dynamic>) {}
  }
}
