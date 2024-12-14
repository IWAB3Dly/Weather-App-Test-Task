part of "weather_data_bloc.dart";

abstract class WeatherDataEvent {}

class LoadWeatherDataForCity extends WeatherDataEvent{
  
  final String cityName;

  LoadWeatherDataForCity({
    required this.cityName
  });

}

