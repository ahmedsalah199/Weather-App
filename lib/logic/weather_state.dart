abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class CurrentWeatherLoadingState extends WeatherState {}

class CurrentWeatherSuccessState extends WeatherState {}

class CurrentWeatherErrorState extends WeatherState {}

class WeatherOfOtherCityLoadingState extends WeatherState {}

class WeatherOfOtherCitySuccessState extends WeatherState {}

class WeatherOfOtherCityErrorState extends WeatherState {}
