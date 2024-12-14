part of "weather_data_bloc.dart";

abstract class WeatherDataState {}

class WeatherDataInitial extends WeatherDataState{
  
}

class WeatherDataLoading extends WeatherDataState{}

class WeatherDataLoaded extends WeatherDataState{

  final WeatherData weatherData;

  WeatherDataLoaded({
    required this.weatherData
  });
}

class WeatherDataError extends WeatherDataState{
  final String errorMessage;

  WeatherDataError({
    required this.errorMessage
  });
}