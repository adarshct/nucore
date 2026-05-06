import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:nucore_project/core/utils/api_paths.dart';
import 'package:nucore_project/presentation/widgets/custom_snackbar.dart';

import 'auth.dart';

class MyDio {
  late Dio dio;

  MyDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiPaths.baseUrl,
        receiveDataWhenStatusError: true,
        responseType: ResponseType.plain,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          // 'User-Agent': 'Android App',
          if (Auth.accessToken.isNotEmpty)
            "Authorization": "Bearer ${Auth.accessToken}",
        },
      ),
    );

    // (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    //   final HttpClient client =
    //       HttpClient(context: SecurityContext(withTrustedRoots: false));
    //   client.badCertificateCallback = (cert, host, port) => true;
    //   return client;
    // };

    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onError: (error, handler) async {
    //       // Check if the error is due to an unauthorized request

    //       if (error.response?.statusCode == 401 ||
    //           error.response?.statusCode == 403) {
    //         if (Auth.refreshToken.isNotEmpty) {
    //           try {
    //             dynamic resp = await AuthRepository.getAccessToken();

    //             if (resp is ValidateModel) {
    //               if (resp.access?.isNotEmpty ?? false) {
    //                 Auth.accessToken = resp.access!;
    //               }
    //             }

    //             if (Auth.accessToken.isEmpty) {
    //               return handler.reject(error);
    //             }

    //             // Clone the original request
    //             final opts = error.requestOptions;
    //             opts.headers['Authorization'] = 'Bearer ${Auth.accessToken}';

    //             // We are going to store the formData in here
    //             dynamic retryFormData = opts.data;

    //             // Check if the request is a file upload
    //             if (opts.data is FormData) {
    //               retryFormData = getFormData(opts.data);
    //             }

    //             // Retry the original request with the new token
    //             final retryResponse = await dio.request(
    //               opts.path,
    //               options: Options(
    //                 method: opts.method,
    //                 headers: opts.headers,
    //                 contentType: opts.contentType,
    //                 responseType: opts.responseType,
    //               ),
    //               data: retryFormData,
    //               queryParameters: opts.queryParameters,
    //             );

    //             // Return the response from the retried request
    //             return handler.resolve(retryResponse);
    //             // }
    //           } on DioException catch (e) {
    //             // Handle errors during the token refresh process
    //             return handler.reject(e);
    //           }
    //         } else {
    //           CustomSnackbar.failedSnackbar("Session expired");
    //           openAsNewPage(const LoginScreen());
    //         }
    //       }

    //       // If the status code is not 401, pass the error on to the handler
    //       return handler.next(error);
    //     },
    //   ),
    // );
  }

  Future<dynamic> get({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response resp = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      printSuccessDetails(resp: resp);
      return jsonDecode(resp.data);
    } on DioException catch (ex) {
      printFailedDetails(ex: ex);
      return ex;
    }
  }

  Future<dynamic> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (data is FormData) {
        dio.options.headers[Headers.contentTypeHeader] =
            Headers.multipartFormDataContentType;
      }

      Response resp = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      printSuccessDetails(resp: resp);
      return jsonDecode(resp.data);
    } on DioException catch (ex) {
      printFailedDetails(ex: ex);
      return ex;
    }
  }

  Future<dynamic> patch({
    required String path,
    required String id,
    dynamic data,
    // bool isFormData = false,
  }) async {
    // await fetchCookieData();

    try {
      if (data is FormData) {
        dio.options.headers[Headers.contentTypeHeader] =
            Headers.multipartFormDataContentType;
      }
      Response resp = await dio.patch("$path$id/", data: data);

      printSuccessDetails(resp: resp);
      return jsonDecode(resp.data);
    } on DioException catch (ex) {
      printFailedDetails(ex: ex);
      return ex;
    }
  }

  Future<dynamic> delete({
    required String path,
    required String id,
    // bool isLogin = false,
  }) async {
    // await fetchCookieData();

    try {
      // if (isLogin) {
      //   dio.options.baseUrl = ApiPaths.loginBaseUrl;
      // }
      Response resp = await dio.delete("$path$id/");

      printSuccessDetails(resp: resp);
      return jsonDecode(resp.data);
    } on DioException catch (ex) {
      printFailedDetails(ex: ex);
      return ex;
    }
  }

  // Future<dynamic> download({
  //   required String path,
  //   String? downloadPath,
  // }) async {
  //   await fetchCookieData();

  //   try {
  //     Response resp = await dio.download(path, downloadPath);

  //     printSuccessDetails(resp: resp);
  //     return resp.data;
  //   } on DioException catch (ex) {
  //     printFailedDetails(ex: ex);
  //     return ex;
  //   }
  // }

  void printSuccessDetails({required Response resp}) {
    log("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
    log(
      "STATUSCODE[${resp.statusCode}] => PATH: ${resp.requestOptions.baseUrl + resp.requestOptions.path}",
    );
    log("ResMethodType : [${resp.requestOptions.method}]");
    log("Headers: ${resp.requestOptions.headers}");
    log("QueryParameters : ${resp.requestOptions.queryParameters.toString()}");
    log("Body: ${resp.requestOptions.data}");
    if (resp.requestOptions.data is FormData) {
      log("FORMDATA START");
      for (MapEntry<String, String> item in resp.requestOptions.data.fields) {
        log(item.toString());
      }
      for (MapEntry<String, MultipartFile> item
          in resp.requestOptions.data.files) {
        log("$item, Filename : ${item.value.filename}");
      }
      log("FORMDATA END");
    }

    log('resp >>> ${resp.data}');

    log("************** Response End ************************");
  }

  void printFailedDetails({required DioException ex}) {
    log("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
    log(
      "REQUEST[${ex.response?.statusCode}] => PATH: ${ex.requestOptions.baseUrl + ex.requestOptions.path}",
    );
    log("ResMethodType : [${ex.requestOptions.method}]");
    log("Headers: ${ex.requestOptions.headers}");
    log("QueryParameters : ${ex.requestOptions.queryParameters.toString()}");
    log("Body: ${ex.requestOptions.data}");
    if (ex.requestOptions.data is FormData) {
      log("FORMDATA START============================");
      for (MapEntry<String, String> item in ex.requestOptions.data.fields) {
        log(item.toString());
      }
      for (MapEntry<String, MultipartFile> item
          in ex.requestOptions.data.files) {
        log("$item, Filename : ${item.value.filename}");
      }
      log("FORMDATA END============================");
    }

    log("Resp >>> ${ex.response}");
    log('error type >>> ${ex.type}');
    log("EXCEPTION : ${ex.message}");
    log("************** Error End ************************");

    String? message = ex.type.name;

    if (ex.type == DioExceptionType.badResponse && ex.response?.data != null) {
      dynamic data = jsonDecode(ex.response?.data);

      message = (data is Map ? data['message']?.toString() : null);
    }

    CustomSnackbar.failedSnackbar(message);
  }

  // Future<void> fetchCookieData() async {
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final cookieJar = PersistCookieJar(
  //     storage: FileStorage('${appDocDir.path}/.cookies/'),
  //   );
  //   dio.interceptors.add(CookieManager(cookieJar));
  // }

  // FormData getFormData(FormData oldFormData) {
  //   // Create a new FormData instance
  //   final newFormData = FormData();

  //   // Clone the fields
  //   newFormData.fields.addAll(oldFormData.fields);

  //   // Clone the files
  //   for (var fileEntry in oldFormData.files) {
  //     newFormData.files.add(
  //       MapEntry(
  //         fileEntry.key,

  //         // This is necessary because we otherwise get a "Bad state: Can't finalize a finalized MultipartFile" error
  //         fileEntry.value.clone(),
  //       ),
  //     );
  //   }

  //   return newFormData;
  // }
}
