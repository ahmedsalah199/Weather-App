import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';
import '../../presentation/resources/strings_manager.dart';

class DioHelper {
  static Dio? dio;

  static initDio() {
    dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: AppConstants.connectTimeOut,
    ));
  }

  static Future<dynamic> getData(
      {required String path, required Map<String, dynamic> query}) async {
    try {
      Response response = await dio!.get(path, queryParameters: query);
      return response.data;
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        throw AppStrings.noInternet;
      } else if (error.type == DioErrorType.other) {
        if (error.message.contains('SocketException')) {
          throw AppStrings.noInternet;
        }
      } else {
        throw Exception(error.toString());
      }
    }
  }
}
