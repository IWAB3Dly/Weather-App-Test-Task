import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_weather_app/data/bloc/weather_data_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _bloc = WeatherDataBloc();

  TextEditingController textController = TextEditingController();

  String currentCityName = "Omsk";

  @override
  void initState() {
    super.initState();
    fetchData(currentCityName);
  }

  void fetchData(String cityName) async{
    _bloc.add(LoadWeatherDataForCity(cityName: cityName));
  }

  void updateData(){
    Timer.periodic(
      const Duration(hours: 1), 
      (timer){
        fetchData(currentCityName);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width-32,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter city name",
                              hintStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5)
                              )
                            ),

                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                            ),

                            onSubmitted: (value) {
                              fetchData(textController.text);
                              textController.clear();
                              setState(() => currentCityName = textController.text);
                            },
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.black.withOpacity(0.5),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<WeatherDataBloc, WeatherDataState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is WeatherDataLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    }
                    else if(state is WeatherDataLoaded){
                      return Padding(
                        padding: const EdgeInsets.only(top: 96),
                        child: Column(
                          children: [
                            Align(
                              widthFactor: (64 - 18 * 2) / 64,
                              heightFactor: (64 - 18 * 2) / 64,
                              child: Image.network(
                                "https:${state.weatherData.iconUrl}",
                              ),
                            ),
                            Text(
                              state.weatherData.cityName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF2C2C2C),
                                fontFamily: "Poppins",
                                fontSize: 45,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              "${state.weatherData.tempC.toInt()}°",
                              style: const TextStyle(
                                color: Color(0xFF2C2C2C),
                                fontFamily: "Poppins",
                                fontSize: 40,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(height: 72),
                          ],
                        ),
                      );
                    }
                    else if(state is WeatherDataError) {
                      if (state.errorMessage.contains("[bad response]")) {
                        return const Center(
                          child: Text(
                            "Похоже такого города не существует",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }
                      else{
                        return const Center(
                          child: Text(
                            "Проверьте интернет соединение",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }
                    }
                    return const Center(child: Text("You did something wrong"));
                  },
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}