import 'dart:ui';
import 'package:cuaca/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color getBackgroundColor(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Colors.orange;
      case >= 300 && < 400:
        return Colors.grey;
      case >= 500 && < 600:
        return Colors.grey;
      case >= 600 && < 700:
        return Colors.grey;
      case >= 700 && < 800:
        return Colors.grey;
      case == 800:
        return Colors.blueAccent;
      case > 800 && <= 804:
        return Colors.grey;
      default:
        return Colors.blueAccent;
    }
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset(
          "assets/thunderstorm.png",
        );
      case >= 300 && < 400:
        return Image.asset(
          "assets/drizzle.png",
        );
      case >= 500 && < 600:
        return Image.asset(
          "assets/rain.png",
        );
      case >= 600 && < 700:
        return Image.asset(
          "assets/snow.png",
        );
      case >= 700 && < 800:
        return Image.asset(
          "assets/atmosphere.png",
        );
      case == 800:
        return Image.asset(
          "assets/clear.png",
        );
      case > 800 && <= 804:
        return Image.asset(
          "assets/cloudy.png",
        );
      default:
        return Image.asset(
          "assets/clouds.png",
        );
    }
  }

  String getGreeting() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return "Selamat Pagi 😁🙏";
    } else if (hour >= 12 && hour < 15) {
      return "Selamat Siang 😁🙏";
    } else if (hour >= 15 && hour < 19) {
      return "Selamat Sore 😁🙏";
    } else {
      return "Selamat Malam 😁🙏";
    }
  }

  String getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case DateTime.monday:
        return "Senin";
      case DateTime.tuesday:
        return "Selasa";
      case DateTime.wednesday:
        return "Rabu";
      case DateTime.thursday:
        return "Kamis";
      case DateTime.friday:
        return "Jum'at";
      case DateTime.saturday:
        return "Sabtu";
      case DateTime.sunday:
        return "Minggu";
      default:
        return '';
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return "Januari";
      case 2:
        return "Februari";
      case 3:
        return "Maret";
      case 4:
        return "April";
      case 5:
        return "Mei";
      case 6:
        return "Juni";
      case 7:
        return "Juli";
      case 8:
        return "Agustus";
      case 9:
        return "September";
      case 10:
        return "Oktober";
      case 11:
        return "November";
      case 12:
        return "Desember";
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            kToolbarHeight,
            20,
            kToolbarHeight,
          ),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherSucces) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Stack(
                    children: [
                      // section - gradation
                      Center(
                        child: Column(
                          children: [
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                color: getBackgroundColor(
                                  state.weather.weatherConditionCode!,
                                ),
                              ),
                            ),
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                color: getBackgroundColor(
                                  state.weather.weatherConditionCode!,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // section - blur background
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 100.0,
                          sigmaY: 100.0,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      // section - main feature
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // section - area name
                            Text(
                              "📍 ${state.weather.areaName}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            // section - greetings
                            Text(
                              getGreeting(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),

                            // section - weather image
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: getWeatherIcon(
                                  state.weather.weatherConditionCode!,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),

                            // section - temperature
                            Center(
                              child: Text(
                                "${state.weather.temperature!.celsius!.round()}°C",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            // section - weather description
                            Center(
                              child: Text(
                                state.weather.weatherDescription!.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            // section - day, date, and time
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text:
                                      "${getDayName(state.weather.date!.toLocal().weekday)}, ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: DateFormat(
                                        "dd ",
                                      ).format(
                                        state.weather.date!.toLocal(),
                                      ),
                                    ),
                                    TextSpan(
                                      text: getMonthName(
                                        state.weather.date!.toLocal().month,
                                      ),
                                    ),
                                    TextSpan(
                                      text: DateFormat(
                                        " • HH:mm ",
                                      ).format(
                                        state.weather.date!.toLocal(),
                                      ),
                                    ),
                                    TextSpan(
                                      text: state.weather.date!.timeZoneName,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),

                            // section - sunset and sunrise
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Color(0xFF171717),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/sunrise.png",
                                            scale: 15,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(
                                                  text: "Matahari",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "\nTerbit",
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  text: DateFormat("HH:mm ")
                                                      .format(
                                                    state.weather.sunrise!,
                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: state
                                                          .weather
                                                          .sunrise!
                                                          .timeZoneName,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Color(0xFF171717),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/sunset.png",
                                            scale: 15,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(
                                                  text: "Matahari",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "\nTerbenam",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  text: DateFormat("HH:mm ")
                                                      .format(
                                                    state.weather.sunset!,
                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: state.weather
                                                          .sunset!.timeZoneName,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            // section - temperature maximum and minimum
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Color(0xFF171717),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/tempMax.png",
                                            scale: 15,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(
                                                  text: "Temperatur",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "\nMaksimum",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "${state.weather.tempMax!.celsius!.round()}°C",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Color(0xFF171717),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/tempMin.png",
                                            scale: 15,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(
                                                  text: "Temperatur",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "\nMinimum",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "${state.weather.tempMin!.celsius!.round()}°C",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            // section - wind speed and cloudiness
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Color(0xFF171717),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/windSpeed.png",
                                            scale: 15,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(
                                                  text: "Kecepatan",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "\nAngin",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "${state.weather.windSpeed.toString()} meter/detik",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Color(0xFF171717),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/cloudiness.png",
                                            scale: 15,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(
                                                  text: "Keadaan",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "\nMendung",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "${state.weather.cloudiness!.round()}%",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            // section - humidity and pressure
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Color(0xFF171717),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/humidity.png",
                                            scale: 15,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(
                                                  text: "Kelembapan",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "${state.weather.humidity!.round()}%",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Color(0xFF171717),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/pressure.png",
                                            scale: 15,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(
                                                  text: "Tekanan",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "${state.weather.pressure!.round()} hPa",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),

                            // section - footer
                            const Center(
                              child: Text(
                                "Cuaca - MRF Projetcs",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
