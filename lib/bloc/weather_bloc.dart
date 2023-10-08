import 'package:bloc/bloc.dart';
import 'package:cuaca/data/my_data.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(
      (event, emit) async {
        emit(WeatherLoading());
        try {
          WeatherFactory wf = WeatherFactory(
            API_KEY,
            language: Language.INDONESIAN,
          );

          Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude,
            event.position.longitude,
          );
          print(weather);
          emit(
            WeatherSucces(weather),
          );
        } catch (e) {
          emit(
            WeatherFailure(),
          );
        }
      },
    );
  }
}
