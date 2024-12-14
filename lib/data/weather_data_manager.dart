import 'package:dio/dio.dart';
import 'package:test_task_weather_app/data/model/weather_data.dart';

class WeatherDataManager {
  final url = "http://api.weatherapi.com/v1/current.json?";
  final key = "e377a42067b245bb89140426241212" ;

  final dio = Dio();

  Future<WeatherData> getWeatherData(String cityName) async{
    final params = {
      "key" : key,
      "q": cityName
    };
    try {
      final response = await dio.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        return WeatherData.fromJSON(response.data);
      }
      else if(response.statusCode == 400){
        throw Exception("There is no such city");
      }
    } catch (e) {
      throw Exception(e);
    }
    throw Exception("Something went wrong");
  }
}