import 'package:bloc/bloc.dart';
import 'package:test_task_weather_app/data/model/weather_data.dart';
import 'package:test_task_weather_app/data/weather_data_manager.dart';

part "weather_data_event.dart";
part "weather_data_state.dart";

class WeatherDataBloc extends Bloc<WeatherDataEvent, WeatherDataState> {

  final _weatherManager = WeatherDataManager();

  WeatherDataBloc() : super(WeatherDataInitial()) {
    on<LoadWeatherDataForCity>(onLoadWeatherData);
  }

  Future<void> onLoadWeatherData(LoadWeatherDataForCity event, Emitter<WeatherDataState> emit) async{
    emit(WeatherDataLoading());
    try {
      final weatherData = await _weatherManager.getWeatherData(event.cityName);
      print(weatherData.iconUrl);
      emit(
        WeatherDataLoaded(
          weatherData: weatherData
        )
      );
    } catch (e) {
      emit(
        WeatherDataError(
          errorMessage: e.toString() 
        )
      );
    }
  }
  
}