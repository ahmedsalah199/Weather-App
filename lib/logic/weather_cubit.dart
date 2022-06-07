import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/repo/weather_repo.dart';
import 'package:weather/logic/weather_state.dart';

import '../data/models/weather_model.dart';
import '../presentation/resources/constants_manager.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit getCubit(context) => BlocProvider.of(context);

  WeatherDataModel? weatherDataModel;
  String? cityName;
  String? errorMsg;

  getCurrentWeather() {
    emit(CurrentWeatherLoadingState());
    WeatherRepo.getWeatherNow(path: 'forecast/daily', query: {
      "key": AppConstants.apiKey,
      "days": 5,
      "city": cityName == null || cityName == '' ? 'cairo' : cityName,
    }).then((value) {
      weatherDataModel = value;
      emit(CurrentWeatherSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CurrentWeatherErrorState());
      errorMsg = error.message.toString();
    });
  }

  List<String> otherCity = [
    "Dubai",
    "Kuwait",
    "Moscow",
    "Riyadh",
    "New York",
    "London",
    "Tokyo",
    "Madrid",
    "Paris",
  ];
  List<WeatherDataModel> weatherOFOtherCity = [];

  getWeatherOfOtherCity() async {
    try {
      for (var city in otherCity) {
        emit(WeatherOfOtherCityLoadingState());
        var data =
            await WeatherRepo.getWeatherNow(path: 'forecast/daily', query: {
          "key": AppConstants.apiKey,
          "days": 1,
          "city": city,
        });
        weatherOFOtherCity.add(data);
        emit(WeatherOfOtherCitySuccessState());
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(WeatherOfOtherCityErrorState());
      errorMsg = (error as dynamic).message.toString();
    }
  }
}
