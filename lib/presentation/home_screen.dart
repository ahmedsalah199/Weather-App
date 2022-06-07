import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/logic/weather_cubit.dart';
import 'package:weather/logic/weather_state.dart';
import 'package:weather/presentation/resources/assets_manger.dart';
import 'package:weather/presentation/resources/colors_manager.dart';
import 'package:weather/presentation/resources/font_manager.dart';
import 'package:weather/presentation/resources/strings_manager.dart';
import 'package:weather/presentation/resources/values_manager.dart';

import '../data/models/weather_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()
        ..getCurrentWeather()
        ..getWeatherOfOtherCity(),
      child: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = WeatherCubit.getCubit(context);
          var weatherModel = WeatherCubit.getCubit(context).weatherDataModel;
          var listWeatherOFOtherCity =
              WeatherCubit.getCubit(context).weatherOFOtherCity;
          return Scaffold(
              body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p40),
                  child: TextFormField(
                    cursorColor: ColorManger.blackColor,
                    onFieldSubmitted: (city) {
                      cubit.cityName = city;
                      cubit.getCurrentWeather();
                      cubit.getWeatherOfOtherCity();
                    },
                    style: const TextStyle(
                        color: ColorManger.whiteColor,
                        fontSize: FontSizeManger.s18),
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.headline2,
                      label: Text(AppStrings.search),
                      suffixIcon: const Icon(Icons.search,
                          color: ColorManger.whiteColor),
                    ),
                  ),
                ),
                if (weatherModel != null && listWeatherOFOtherCity.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              (weatherModel.cityName.toString()),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            Text(
                              '${(weatherModel.weatherOfFiveDays[0].temp!).round()}°',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: AppSize.s15,
                            ),
                            Text(
                              ('${weatherModel.weatherOfFiveDays[0].weather!.description}'),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: AppMargin.m15,
                                  horizontal: AppMargin.m15),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s30),
                              ),
                              child: Center(
                                child: Text(
                                  AppStrings.fiveDayForecast,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  buildFiveDayForecast(
                                      weatherModel.weatherOfFiveDays[index],
                                      context),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: AppSize.s15,
                              ),
                              itemCount: weatherModel.weatherOfFiveDays.length,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: AppMargin.m15,
                                  horizontal: AppMargin.m15),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s30),
                              ),
                              child: Center(
                                child: Text(
                                  AppStrings.otherCities,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ),
                            Container(
                              height: AppSize.s190,
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => buildOtherCity(
                                    listWeatherOFOtherCity[index], context),
                                itemCount: listWeatherOFOtherCity.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else if (state is CurrentWeatherLoadingState ||
                    state is WeatherOfOtherCityLoadingState)
                  const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: ColorManger.whiteColor,
                    )),
                  )
                else if (state is CurrentWeatherErrorState ||
                    state is WeatherOfOtherCityErrorState)
                  Expanded(
                    child: Center(
                      child: Text(
                        cubit.errorMsg.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),
              ],
            ),
          ));
        },
      ),
    );
  }

  String getDayOfForecast(WeatherOfFiveDays weather) {
    var date = weather.datetime;
    DateTime dateTime = DateTime.parse(date!);
    String dayOfForecast = DateFormat('EEE').format(dateTime);

    final now = DateTime.now();
    final today =
        DateFormat('EEE').format(DateTime(now.year, now.month, now.day));
    final tomorrow =
        DateFormat('EEE').format(DateTime(now.year, now.month, now.day + 1));
    final yesterday =
        DateFormat('EEE').format(DateTime(now.year, now.month, now.day - 1));

    if (dayOfForecast == today) {
      return AppStrings.today;
    } else if (dayOfForecast == tomorrow) {
      return AppStrings.tomorrow;
    } else if (dayOfForecast == yesterday) {
      return AppStrings.yesterday;
    } else {
      return dayOfForecast;
    }
  }

  Widget buildFiveDayForecast(
      WeatherOfFiveDays weatherModel, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                '${ImageAssets.icon}${weatherModel.weather!.icon}.png',
                height: AppSize.s30,
                width: AppSize.s30,
              ),
              const SizedBox(
                width: AppSize.s12,
              ),
              Flexible(
                child: Text(
                  ('${getDayOfForecast(weatherModel)} - ${weatherModel.weather!.description}'),
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${(weatherModel.maxTemp)!.round()}° / ${(weatherModel.minTemp)!.round()}°',
          style: Theme.of(context).textTheme.headline2,
        )
      ],
    );
  }
}

Widget buildOtherCity(WeatherDataModel weatherModel, BuildContext context) {
  return SizedBox(
    width: AppSize.s150,
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: AppSize.s80,
            width: AppSize.s80,
            child: Image.asset(
              '${ImageAssets.icon}${weatherModel.weatherOfFiveDays[0].weather!.icon}.png',
            ),
          ),
          Text(
            ('${(weatherModel.weatherOfFiveDays[0].temp)!.round()}°'),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            (weatherModel.cityName.toString()),
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    ),
  );
}
