

class Meteo{
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double humidity;
  final double windSpeed;
  final double visibility;
  final List days;
  final String icon;

  static int index = 0;
  static String firstDay = '';

  Meteo({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.days,
    required this.icon
  });

  factory Meteo.fromJson(Map<String, dynamic> json)
  {
    //print("Type = ${json['days'][0]['hours'][0]['datetime']}");
    // firstDay = json['list'][Meteo.index]['dt_txt'].split(' ')[0];
    // hourlyDays = json['list'];
    return Meteo
    (
      cityName: json['address'],
      visibility: json['currentConditions']['visibility'],
      temperature: json['currentConditions']['temp'],
      mainCondition: json['currentConditions']['conditions'],
      humidity: json['currentConditions']['humidity'],
      windSpeed: json['currentConditions']['windspeed'],
      icon: json['currentConditions']['icon'],
      days: json['days']

    );
  }
  //
  // List<Map<String, dynamic>>? getDays()
  // {
  //   List<Map<String, dynamic>>? listDays = [{}];
  //   int j = 0;
  //   for(int i = 0; i < hourlyDays.length; i++)
  //   {
  //     if(hourlyDays[i]['dt_txt'] == firstDay)
  //     {
  //       if(listDays[0].isNotEmpty)
  //       {
  //         //listDays.add({});
  //         listDays[0]['heurs'] = [
  //           hourlyDays[i],
  //         ];
  //       }else
  //       {
  //         listDays[j]['heurs']?.add(hourlyDays[i]);
  //       }
  //     }else
  //     {
  //       j++;
  //       listDays.add({});
  //       listDays[j]['heurs'] = [];
  //       listDays[j]['heurs']?.add(hourlyDays[i]);
  //       firstDay = hourlyDays[i]['dt_txt'];
  //     }
  //     print(j);
  //   }
  //   return listDays;
  // }


  bool getMomentOfDay(){
    // Récupération de l'heure actuelle
    DateTime maintenant = DateTime.now();

    // Définition de l'heure de début et de fin de la nuit (par exemple, de 18h à 6h)
    int heureDebutNuit = 20;
    int heureFinNuit = 6;

    // Vérification si l'heure actuelle est dans la plage de la nuit
    bool ilFaitNuit = (maintenant.hour >= heureDebutNuit || maintenant.hour < heureFinNuit);

    return ilFaitNuit;
  }

  String getWeather(){

    if(!getMomentOfDay()) {
      if(this.mainCondition == null) return 'assets/json/sunny.json';
      switch (this.mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/images/cloud_nuage_simple.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/json/rain.json';
        case 'thunderstorm':
          return 'assets/json/thunder.json';
        case 'clear':
          return 'assets/json/sunny.json';
        default:
          return 'assets/json/sunny.json';
      }
    }else{
      if(mainCondition == null) return 'assets/json/sunny_nuit.json';
      switch (mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/json/rain_nuit.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/json/sunny_nuit.json';
        case 'thunderstorm':
          return 'assets/json/thunder_nuit.json';
        case 'clear':
          return 'assets/json/sunny_nuit.json';
        default:
          return 'assets/json/sunny_nuit.json';
      }
    }
  }

  // final test = [
  //   {
  //     'heurs':[
  //       {}
  //     ]
  //   },
  //   {
  //     'heurs':[
  //       {}
  //     ]
  //   },
  //
  // ];

}