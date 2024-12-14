class WeatherData {
  
  final String cityName;
  final String iconUrl;
  
  final double tempC;

  const WeatherData({
    required this.cityName,
    required this.iconUrl,
    required this.tempC,
  });

  factory WeatherData.fromJSON(Map<String, dynamic> json) => WeatherData(
    cityName: json["location"]["name"], 
    iconUrl: json["current"]["condition"]["icon"], 
    tempC: json["current"]["temp_c"]
  );

}