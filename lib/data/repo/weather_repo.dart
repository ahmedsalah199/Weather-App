import 'package:weather/data/models/weather_model.dart';

import '../../presentation/resources/strings_manager.dart';
import '../services/api.dart';

class WeatherRepo {
  static dynamic data;
  static Future<WeatherDataModel> getWeatherNow(
      {required String path, required Map<String, dynamic> query}) async {
    try {
      data = await DioHelper.getData(path: path, query: query);
      return WeatherDataModel.fromJson(data);
    } catch (error) {
      if (data.runtimeType == String) {
        throw Exception(AppStrings.noResultsFound);
      } else {
        throw Exception(error.toString());
      }
    }
  }
}
