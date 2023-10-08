part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherFailure extends WeatherState {}

final class WeatherSucces extends WeatherState {
  final Weather weather;

  const WeatherSucces(this.weather);

  @override
  List<Object> get props => [weather];
}
