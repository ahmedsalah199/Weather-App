class WeatherDataModel {
  String? cityName;

  List<WeatherOfFiveDays> weatherOfFiveDays = [];

  WeatherDataModel.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    if (json['data'] != null) {
      json['data'].forEach((data) {
        weatherOfFiveDays.add(WeatherOfFiveDays.fromJson(data));
      });
    }
  }
}

class WeatherOfFiveDays {
  dynamic temp;
  dynamic maxTemp;
  dynamic minTemp;
  String? datetime;
  Weather? weather;

  WeatherOfFiveDays.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    maxTemp = json['max_temp'];
    minTemp = json['min_temp'];
    datetime = json['datetime'];
    weather = Weather.fromJson(json['weather']);
  }
}

class Weather {
  String? description;
  String? icon;

  Weather.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    icon = json['icon'];
  }
}
