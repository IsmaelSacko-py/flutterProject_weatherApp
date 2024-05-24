import 'dart:convert';

import '../models/meteo.dart';
import 'package:http/http.dart' as http;

class Ville{
  String nom;
  // Meteo? _meteo;
  // Map<String, dynamic> json = {
  //   "cod": "200",
  //   "message": 0,
  //   "cnt": 40,
  //   "list": [
  //     {
  //       "dt": 1709845200,
  //       "main": {
  //         "temp": 21.49,
  //         "feels_like": 21.97,
  //         "temp_min": 20.35,
  //         "temp_max": 21.49,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1012,
  //         "humidity": 87,
  //         "temp_kf": 1.14
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 14
  //       },
  //       "wind": {
  //         "speed": 8.44,
  //         "deg": 356,
  //         "gust": 11.79
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-07 21:00:00"
  //     },
  //     {
  //       "dt": 1709856000,
  //       "main": {
  //         "temp": 21.05,
  //         "feels_like": 21.48,
  //         "temp_min": 20.16,
  //         "temp_max": 21.05,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1013,
  //         "humidity": 87,
  //         "temp_kf": 0.89
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 23
  //       },
  //       "wind": {
  //         "speed": 7.58,
  //         "deg": 358,
  //         "gust": 11.1
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-08 00:00:00"
  //     },
  //     {
  //       "dt": 1709866800,
  //       "main": {
  //         "temp": 20.61,
  //         "feels_like": 20.97,
  //         "temp_min": 20.17,
  //         "temp_max": 20.61,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1011,
  //         "humidity": 86,
  //         "temp_kf": 0.44
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 8
  //       },
  //       "wind": {
  //         "speed": 8.25,
  //         "deg": 353,
  //         "gust": 12.07
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-08 03:00:00"
  //     },
  //     {
  //       "dt": 1709877600,
  //       "main": {
  //         "temp": 20.12,
  //         "feels_like": 20.49,
  //         "temp_min": 20.12,
  //         "temp_max": 20.12,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 88,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 5
  //       },
  //       "wind": {
  //         "speed": 8.5,
  //         "deg": 359,
  //         "gust": 12.54
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-08 06:00:00"
  //     },
  //     {
  //       "dt": 1709888400,
  //       "main": {
  //         "temp": 20.39,
  //         "feels_like": 20.7,
  //         "temp_min": 20.39,
  //         "temp_max": 20.39,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1012,
  //         "humidity": 85,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 2
  //       },
  //       "wind": {
  //         "speed": 9.01,
  //         "deg": 360,
  //         "gust": 12.91
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-08 09:00:00"
  //     },
  //     {
  //       "dt": 1709899200,
  //       "main": {
  //         "temp": 20.94,
  //         "feels_like": 21.18,
  //         "temp_min": 20.94,
  //         "temp_max": 20.94,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1013,
  //         "humidity": 80,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 16
  //       },
  //       "wind": {
  //         "speed": 7.73,
  //         "deg": 6,
  //         "gust": 10.9
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-08 12:00:00"
  //     },
  //     {
  //       "dt": 1709910000,
  //       "main": {
  //         "temp": 21.02,
  //         "feels_like": 21.21,
  //         "temp_min": 21.02,
  //         "temp_max": 21.02,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 78,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 803,
  //           "main": "Clouds",
  //           "description": "broken clouds",
  //           "icon": "04d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 80
  //       },
  //       "wind": {
  //         "speed": 7.48,
  //         "deg": 359,
  //         "gust": 10.15
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-08 15:00:00"
  //     },
  //     {
  //       "dt": 1709920800,
  //       "main": {
  //         "temp": 20.79,
  //         "feels_like": 20.94,
  //         "temp_min": 20.79,
  //         "temp_max": 20.79,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1010,
  //         "humidity": 77,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 804,
  //           "main": "Clouds",
  //           "description": "overcast clouds",
  //           "icon": "04d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 86
  //       },
  //       "wind": {
  //         "speed": 7.64,
  //         "deg": 354,
  //         "gust": 10.31
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-08 18:00:00"
  //     },
  //     {
  //       "dt": 1709931600,
  //       "main": {
  //         "temp": 20.66,
  //         "feels_like": 20.82,
  //         "temp_min": 20.66,
  //         "temp_max": 20.66,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1012,
  //         "humidity": 78,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 804,
  //           "main": "Clouds",
  //           "description": "overcast clouds",
  //           "icon": "04n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 85
  //       },
  //       "wind": {
  //         "speed": 7.39,
  //         "deg": 349,
  //         "gust": 10.78
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-08 21:00:00"
  //     },
  //     {
  //       "dt": 1709942400,
  //       "main": {
  //         "temp": 20.6,
  //         "feels_like": 20.86,
  //         "temp_min": 20.6,
  //         "temp_max": 20.6,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1012,
  //         "humidity": 82,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 804,
  //           "main": "Clouds",
  //           "description": "overcast clouds",
  //           "icon": "04n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 93
  //       },
  //       "wind": {
  //         "speed": 7.43,
  //         "deg": 348,
  //         "gust": 11.26
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-09 00:00:00"
  //     },
  //     {
  //       "dt": 1709953200,
  //       "main": {
  //         "temp": 20.44,
  //         "feels_like": 20.73,
  //         "temp_min": 20.44,
  //         "temp_max": 20.44,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 84,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 803,
  //           "main": "Clouds",
  //           "description": "broken clouds",
  //           "icon": "04n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 68
  //       },
  //       "wind": {
  //         "speed": 7.75,
  //         "deg": 354,
  //         "gust": 11.83
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-09 03:00:00"
  //     },
  //     {
  //       "dt": 1709964000,
  //       "main": {
  //         "temp": 20.21,
  //         "feels_like": 20.53,
  //         "temp_min": 20.21,
  //         "temp_max": 20.21,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 86,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 803,
  //           "main": "Clouds",
  //           "description": "broken clouds",
  //           "icon": "04n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 73
  //       },
  //       "wind": {
  //         "speed": 8.24,
  //         "deg": 1,
  //         "gust": 12.59
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-09 06:00:00"
  //     },
  //     {
  //       "dt": 1709974800,
  //       "main": {
  //         "temp": 20.36,
  //         "feels_like": 20.67,
  //         "temp_min": 20.36,
  //         "temp_max": 20.36,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1012,
  //         "humidity": 85,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 802,
  //           "main": "Clouds",
  //           "description": "scattered clouds",
  //           "icon": "03d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 39
  //       },
  //       "wind": {
  //         "speed": 8.54,
  //         "deg": 8,
  //         "gust": 12.28
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-09 09:00:00"
  //     },
  //     {
  //       "dt": 1709985600,
  //       "main": {
  //         "temp": 21,
  //         "feels_like": 21.22,
  //         "temp_min": 21,
  //         "temp_max": 21,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1013,
  //         "humidity": 79,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 802,
  //           "main": "Clouds",
  //           "description": "scattered clouds",
  //           "icon": "03d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 41
  //       },
  //       "wind": {
  //         "speed": 7.62,
  //         "deg": 11,
  //         "gust": 10.88
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-09 12:00:00"
  //     },
  //     {
  //       "dt": 1709996400,
  //       "main": {
  //         "temp": 21.1,
  //         "feels_like": 21.2,
  //         "temp_min": 21.1,
  //         "temp_max": 21.1,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 74,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 802,
  //           "main": "Clouds",
  //           "description": "scattered clouds",
  //           "icon": "03d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 45
  //       },
  //       "wind": {
  //         "speed": 7.89,
  //         "deg": 0,
  //         "gust": 10.54
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-09 15:00:00"
  //     },
  //     {
  //       "dt": 1710007200,
  //       "main": {
  //         "temp": 20.8,
  //         "feels_like": 20.89,
  //         "temp_min": 20.8,
  //         "temp_max": 20.8,
  //         "pressure": 1011,
  //         "sea_level": 1011,
  //         "grnd_level": 1010,
  //         "humidity": 75,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 802,
  //           "main": "Clouds",
  //           "description": "scattered clouds",
  //           "icon": "03d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 32
  //       },
  //       "wind": {
  //         "speed": 8.35,
  //         "deg": 356,
  //         "gust": 11.31
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-09 18:00:00"
  //     },
  //     {
  //       "dt": 1710018000,
  //       "main": {
  //         "temp": 20.58,
  //         "feels_like": 20.73,
  //         "temp_min": 20.58,
  //         "temp_max": 20.58,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1012,
  //         "humidity": 78,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 4
  //       },
  //       "wind": {
  //         "speed": 8.07,
  //         "deg": 357,
  //         "gust": 12.08
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-09 21:00:00"
  //     },
  //     {
  //       "dt": 1710028800,
  //       "main": {
  //         "temp": 20.59,
  //         "feels_like": 20.82,
  //         "temp_min": 20.59,
  //         "temp_max": 20.59,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1012,
  //         "humidity": 81,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 17
  //       },
  //       "wind": {
  //         "speed": 7.93,
  //         "deg": 359,
  //         "gust": 12.46
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-10 00:00:00"
  //     },
  //     {
  //       "dt": 1710039600,
  //       "main": {
  //         "temp": 20.41,
  //         "feels_like": 20.65,
  //         "temp_min": 20.41,
  //         "temp_max": 20.41,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 82,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 802,
  //           "main": "Clouds",
  //           "description": "scattered clouds",
  //           "icon": "03n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 42
  //       },
  //       "wind": {
  //         "speed": 8.3,
  //         "deg": 2,
  //         "gust": 12.91
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-10 03:00:00"
  //     },
  //     {
  //       "dt": 1710050400,
  //       "main": {
  //         "temp": 20.28,
  //         "feels_like": 20.5,
  //         "temp_min": 20.28,
  //         "temp_max": 20.28,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 82,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 802,
  //           "main": "Clouds",
  //           "description": "scattered clouds",
  //           "icon": "03n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 45
  //       },
  //       "wind": {
  //         "speed": 8.22,
  //         "deg": 10,
  //         "gust": 13.05
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-10 06:00:00"
  //     },
  //     {
  //       "dt": 1710061200,
  //       "main": {
  //         "temp": 20.34,
  //         "feels_like": 20.54,
  //         "temp_min": 20.34,
  //         "temp_max": 20.34,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1013,
  //         "humidity": 81,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 9
  //       },
  //       "wind": {
  //         "speed": 8.41,
  //         "deg": 17,
  //         "gust": 12.39
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-10 09:00:00"
  //     },
  //     {
  //       "dt": 1710072000,
  //       "main": {
  //         "temp": 21.01,
  //         "feels_like": 21.12,
  //         "temp_min": 21.01,
  //         "temp_max": 21.01,
  //         "pressure": 1015,
  //         "sea_level": 1015,
  //         "grnd_level": 1013,
  //         "humidity": 75,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 9
  //       },
  //       "wind": {
  //         "speed": 7.87,
  //         "deg": 16,
  //         "gust": 11.29
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-10 12:00:00"
  //     },
  //     {
  //       "dt": 1710082800,
  //       "main": {
  //         "temp": 21.31,
  //         "feels_like": 21.27,
  //         "temp_min": 21.31,
  //         "temp_max": 21.31,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 68,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 802,
  //           "main": "Clouds",
  //           "description": "scattered clouds",
  //           "icon": "03d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 26
  //       },
  //       "wind": {
  //         "speed": 7.84,
  //         "deg": 2,
  //         "gust": 10.5
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-10 15:00:00"
  //     },
  //     {
  //       "dt": 1710093600,
  //       "main": {
  //         "temp": 21.17,
  //         "feels_like": 21.2,
  //         "temp_min": 21.17,
  //         "temp_max": 21.17,
  //         "pressure": 1011,
  //         "sea_level": 1011,
  //         "grnd_level": 1010,
  //         "humidity": 71,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 16
  //       },
  //       "wind": {
  //         "speed": 7.9,
  //         "deg": 352,
  //         "gust": 10.93
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-10 18:00:00"
  //     },
  //     {
  //       "dt": 1710104400,
  //       "main": {
  //         "temp": 20.95,
  //         "feels_like": 21.03,
  //         "temp_min": 20.95,
  //         "temp_max": 20.95,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1012,
  //         "humidity": 74,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 16
  //       },
  //       "wind": {
  //         "speed": 7.65,
  //         "deg": 354,
  //         "gust": 11.68
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-10 21:00:00"
  //     },
  //     {
  //       "dt": 1710115200,
  //       "main": {
  //         "temp": 20.87,
  //         "feels_like": 21,
  //         "temp_min": 20.87,
  //         "temp_max": 20.87,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1013,
  //         "humidity": 76,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 22
  //       },
  //       "wind": {
  //         "speed": 7.28,
  //         "deg": 359,
  //         "gust": 11.62
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-11 00:00:00"
  //     },
  //     {
  //       "dt": 1710126000,
  //       "main": {
  //         "temp": 20.74,
  //         "feels_like": 20.93,
  //         "temp_min": 20.74,
  //         "temp_max": 20.74,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1011,
  //         "humidity": 79,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 22
  //       },
  //       "wind": {
  //         "speed": 7.93,
  //         "deg": 0,
  //         "gust": 12.2
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-11 03:00:00"
  //     },
  //     {
  //       "dt": 1710136800,
  //       "main": {
  //         "temp": 20.37,
  //         "feels_like": 20.66,
  //         "temp_min": 20.37,
  //         "temp_max": 20.37,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1012,
  //         "humidity": 84,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 802,
  //           "main": "Clouds",
  //           "description": "scattered clouds",
  //           "icon": "03n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 38
  //       },
  //       "wind": {
  //         "speed": 6.62,
  //         "deg": 8,
  //         "gust": 10.59
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-11 06:00:00"
  //     },
  //     {
  //       "dt": 1710147600,
  //       "main": {
  //         "temp": 20.58,
  //         "feels_like": 20.83,
  //         "temp_min": 20.58,
  //         "temp_max": 20.58,
  //         "pressure": 1015,
  //         "sea_level": 1015,
  //         "grnd_level": 1013,
  //         "humidity": 82,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 803,
  //           "main": "Clouds",
  //           "description": "broken clouds",
  //           "icon": "04d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 83
  //       },
  //       "wind": {
  //         "speed": 6.9,
  //         "deg": 16,
  //         "gust": 10.16
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-11 09:00:00"
  //     },
  //     {
  //       "dt": 1710158400,
  //       "main": {
  //         "temp": 21.47,
  //         "feels_like": 21.66,
  //         "temp_min": 21.47,
  //         "temp_max": 21.47,
  //         "pressure": 1015,
  //         "sea_level": 1015,
  //         "grnd_level": 1014,
  //         "humidity": 76,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 803,
  //           "main": "Clouds",
  //           "description": "broken clouds",
  //           "icon": "04d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 72
  //       },
  //       "wind": {
  //         "speed": 7.04,
  //         "deg": 10,
  //         "gust": 9.58
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-11 12:00:00"
  //     },
  //     {
  //       "dt": 1710169200,
  //       "main": {
  //         "temp": 21.75,
  //         "feels_like": 21.89,
  //         "temp_min": 21.75,
  //         "temp_max": 21.75,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1012,
  //         "humidity": 73,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 804,
  //           "main": "Clouds",
  //           "description": "overcast clouds",
  //           "icon": "04d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 85
  //       },
  //       "wind": {
  //         "speed": 6.84,
  //         "deg": 357,
  //         "gust": 9.22
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-11 15:00:00"
  //     },
  //     {
  //       "dt": 1710180000,
  //       "main": {
  //         "temp": 21.81,
  //         "feels_like": 22,
  //         "temp_min": 21.81,
  //         "temp_max": 21.81,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 75,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 803,
  //           "main": "Clouds",
  //           "description": "broken clouds",
  //           "icon": "04d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 66
  //       },
  //       "wind": {
  //         "speed": 7.06,
  //         "deg": 342,
  //         "gust": 9.6
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-11 18:00:00"
  //     },
  //     {
  //       "dt": 1710190800,
  //       "main": {
  //         "temp": 21.27,
  //         "feels_like": 21.52,
  //         "temp_min": 21.27,
  //         "temp_max": 21.27,
  //         "pressure": 1014,
  //         "sea_level": 1014,
  //         "grnd_level": 1013,
  //         "humidity": 79,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 15
  //       },
  //       "wind": {
  //         "speed": 6.71,
  //         "deg": 346,
  //         "gust": 10.17
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-11 21:00:00"
  //     },
  //     {
  //       "dt": 1710201600,
  //       "main": {
  //         "temp": 21.17,
  //         "feels_like": 21.43,
  //         "temp_min": 21.17,
  //         "temp_max": 21.17,
  //         "pressure": 1015,
  //         "sea_level": 1015,
  //         "grnd_level": 1014,
  //         "humidity": 80,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 13
  //       },
  //       "wind": {
  //         "speed": 6.7,
  //         "deg": 345,
  //         "gust": 10.43
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-12 00:00:00"
  //     },
  //     {
  //       "dt": 1710212400,
  //       "main": {
  //         "temp": 20.89,
  //         "feels_like": 21.12,
  //         "temp_min": 20.89,
  //         "temp_max": 20.89,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1012,
  //         "humidity": 80,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 801,
  //           "main": "Clouds",
  //           "description": "few clouds",
  //           "icon": "02n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 11
  //       },
  //       "wind": {
  //         "speed": 6.03,
  //         "deg": 358,
  //         "gust": 9.6
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-12 03:00:00"
  //     },
  //     {
  //       "dt": 1710223200,
  //       "main": {
  //         "temp": 20.51,
  //         "feels_like": 20.78,
  //         "temp_min": 20.51,
  //         "temp_max": 20.51,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1012,
  //         "humidity": 83,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01n"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 8
  //       },
  //       "wind": {
  //         "speed": 5.78,
  //         "deg": 8,
  //         "gust": 9.15
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "n"
  //       },
  //       "dt_txt": "2024-03-12 06:00:00"
  //     },
  //     {
  //       "dt": 1710234000,
  //       "main": {
  //         "temp": 20.81,
  //         "feels_like": 21.06,
  //         "temp_min": 20.81,
  //         "temp_max": 20.81,
  //         "pressure": 1015,
  //         "sea_level": 1015,
  //         "grnd_level": 1013,
  //         "humidity": 81,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 3
  //       },
  //       "wind": {
  //         "speed": 6.34,
  //         "deg": 15,
  //         "gust": 9.44
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-12 09:00:00"
  //     },
  //     {
  //       "dt": 1710244800,
  //       "main": {
  //         "temp": 21.52,
  //         "feels_like": 21.74,
  //         "temp_min": 21.52,
  //         "temp_max": 21.52,
  //         "pressure": 1015,
  //         "sea_level": 1015,
  //         "grnd_level": 1014,
  //         "humidity": 77,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 3
  //       },
  //       "wind": {
  //         "speed": 6.74,
  //         "deg": 8,
  //         "gust": 9.32
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-12 12:00:00"
  //     },
  //     {
  //       "dt": 1710255600,
  //       "main": {
  //         "temp": 21.69,
  //         "feels_like": 21.93,
  //         "temp_min": 21.69,
  //         "temp_max": 21.69,
  //         "pressure": 1013,
  //         "sea_level": 1013,
  //         "grnd_level": 1011,
  //         "humidity": 77,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 2
  //       },
  //       "wind": {
  //         "speed": 6.64,
  //         "deg": 356,
  //         "gust": 8.86
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-12 15:00:00"
  //     },
  //     {
  //       "dt": 1710266400,
  //       "main": {
  //         "temp": 21.84,
  //         "feels_like": 22.09,
  //         "temp_min": 21.84,
  //         "temp_max": 21.84,
  //         "pressure": 1012,
  //         "sea_level": 1012,
  //         "grnd_level": 1011,
  //         "humidity": 77,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 800,
  //           "main": "Clear",
  //           "description": "clear sky",
  //           "icon": "01d"
  //         }
  //       ],
  //       "clouds": {
  //         "all": 4
  //       },
  //       "wind": {
  //         "speed": 7.03,
  //         "deg": 347,
  //         "gust": 9.47
  //       },
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {
  //         "pod": "d"
  //       },
  //       "dt_txt": "2024-03-12 18:00:00"
  //     }
  //   ],
  //   "city": {
  //     "id": 2253354,
  //     "name": "Dakar",
  //     "coord": {
  //       "lat": 14.6937,
  //       "lon": -17.4441
  //     },
  //     "country": "SN",
  //     "population": 2476400,
  //     "timezone": 0,
  //     "sunrise": 1709796165,
  //     "sunset": 1709839137
  //   }
  // };
  // static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';


  // openweather Api
  // static const BASE_URL = "https://api.openweathermap.org/data/2.5/forecast";
  // final String apiKey = "2bd434f25a8f58083cfe2bfc0840657e";

  // visaulcrossing Api
  static const BASE_URL = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline";
  static const BASE_URL2 = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline";
  final String apiKey = "WJDJKV7WWMZX356YM527U7JNV";


  // Nombre de jours de previsions
  static const forecastDays = 10;

  Ville(this.nom);


  Future<Meteo> getMeteo() async
  {
    // openweather getResponse
    // final response = await http.get(
    //     Uri.parse('$BASE_URL?q=${this.nom}&units=metric&lan=fr&appid=$apiKey')
    // );

    // visualcrossing getResponse
    final response = await http.get(
        Uri.parse('$BASE_URL//${this.nom}/next${forecastDays}days?unitGroup=metric&lang=fr&contentType=json&key=$apiKey')
        //Uri.parse('$BASE_URL2//${this.nom}?unitGroup=metric&lang=fr&key=${apiKey}&contentType=json')
    );

    if (response.statusCode == 200) {
      return Meteo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("getWeatherDataException");
    }
  }


}