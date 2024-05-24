
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterproject_applicationmeteo/screens/selectVille.dart';
import 'package:flutterproject_applicationmeteo/services/meteo_service.dart';
import 'package:french_date_formatter/french_date_formatter.dart';
import 'package:intl/intl.dart';
import '../models/meteo.dart';
import '../models/ville.dart';
import '../utils/constante.dart';
import 'forecast.dart';

class DetailVille extends StatefulWidget {

  Meteo? meteo;
  List<Meteo> autresVilles;
  //required this.meteo, required this.autresVilles,
  // {(meteo!.visibility/1000).round()}
  DetailVille({ required this.meteo, required this.autresVilles, super.key});

  @override
  State<DetailVille> createState() => _DetailVilleState();
}

class _DetailVilleState extends State<DetailVille> {
  String apiKey = "ce0ca1a2cec0a0e11b560dca2c4a0934";



  bool _visibility = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _fetchMeteo();
  }

  @override
  Widget build(BuildContext context) {
    final meteo = widget.meteo;
    final autresVilles = widget.autresVilles;
    //autresVilles.remove(meteo);

    // Donne les heures du jour actuelle
    final heures = meteo?.days[0]['hours'];

    // Permet de tronquer l'heure actuelle. AU lieu d'avoir 16:45:23, on aura 16:00:00
    final DateTime dateActuelle = DateTime.now();
    final int heureActuelle = dateActuelle.hour;
    DateTime maintenant = DateTime(0, 0, 0, heureActuelle, 0, 0);
    final tempsActuelle = DateFormat.Hms().format(maintenant);







    List ForcastHoursByThreeStep(){
      // Crée une sous liste des heure à partir de l'heure actuelle
      /*
      heureActuelle - 1 : se justifie par le fait que l'API retourne des heures comprises
      entre 00:00:00 et 23:00:00. De ce fait, il fait 16:00:00 (heure actuelle),
      les previsions correspond a cette heure, seront celles de 15:00:00 dans la reponse API
     */
      // print("heure $heureActuelle");
      // int startIndexSublist = (heureActuelle == 0)? 23 : heureActuelle;
      final heureActuelle_heureFinDeJournee = heures.sublist(heureActuelle);
      //final currentDayCondition = meteo?.days[0]['hours'];
      List hoursByTrheeStep = [
        for(int i = 0; i < heureActuelle_heureFinDeJournee.length; i+=2) heureActuelle_heureFinDeJournee[i]
      ];

      /*
      Etant donné que l'on souhaite afficher 12 previsions horaires par intervalle de 2h,
      si jamais le nombre de previsions horaires du jour actuel (de maintenant jusqu'à la fin du jour)
      n'atteignent pas 12, le reste sera pris dans celles du jour suivant.
       */
      if(hoursByTrheeStep.length < 12)
      {
        final heures = meteo?.days[1]['hours'];
        String lastHour = hoursByTrheeStep.last['datetime'].split(':')[0];
        int startIndex = (lastHour == '23')? 1 : 0;
        for(int i = startIndex; i < heures.length; i+=2)
        {
          hoursByTrheeStep.add(heures[i]);
          if(hoursByTrheeStep.length == 12) break;

        }
      }
      return hoursByTrheeStep;
    }


    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    //final String dateTime = formatter.format(now);


    //print(meteo?.getDays());

    return Scaffold(
      // backgroundColor: const Color(0xff5842A9),
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w400
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('${meteo?.cityName}'),
      ),
      body: SafeArea(
        child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 30,
                    sigmaY: 30,
                  ),
                  child: Image(
                    image: AssetImage(
                      '$imageBasePath/appBg.png',
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          utf8.decode(meteo!.mainCondition.codeUnits),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                      ),
                      Image.asset(
                          width: 120,
                          height: 120,
                          "assets/weatherIcons/${meteo?.icon}.png"
                      ),
                      Text(
                        "${DateFormat.MMMEd().format(dateActuelle)} | ${ForcastHoursByThreeStep()[0]['datetime'].substring(0, 5)}",
                        // "${FrenchDateFormatter.formatDateFR(dateActuelle.toString())} | ${ForcastHoursByThreeStep()[0]['datetime'].substring(0, 5)}",
                        // "${DateFormat.MMMEd().format(dateActuelle)} | ${ForcastHoursByThreeStep()[0]['datetime'].substring(0, 5)}",
                        //(DateTime.parse(heureActuelle_heureFinDeJournee[0]['datetime']).add(Duration(hours: 1))).toString(),
                        //DateTime.parse(meteo['datetime']).add(Duration())
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${meteo?.temperature.round()}°',
                        style: TextStyle(
                            fontSize: 80,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Container(
                        height: 110,
                        width: 400,
                        decoration: BoxDecoration(
                            color: foregroundColor,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(top: 15)),
                                      Image(
                                          height: 40,
                                          image: AssetImage(
                                            'assets/icons/visibility.png',
                                          )
                                      ),
                                      Text(
                                        '${meteo?.visibility.round()} km',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white
                                        ),
                                      ),
                                      Text(
                                        'Visibilité',
                                        style:
                                        TextStyle(
                                            fontSize: 15,
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        height: 50,
                                        'assets/icons/humidity.svg',
                                      ),
                                      Text(
                                        '${meteo?.humidity.round()}%',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Humidité',
                                        style:
                                        TextStyle(fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Column(
                                    children: [
                                      Image(
                                          height: 50,
                                          image: AssetImage(
                                            'assets/icons/vent.png',
                                          )),
                                      Text(
                                        '${meteo?.windSpeed.round()} km/h',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Vent',
                                        style:
                                        TextStyle(fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 400,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Aujourd\'hui',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 17),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'Prévisions sur ${Ville.forecastDays} jours >',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 17),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context){
                                          return Forecast(meteo: meteo,);
                                        }
                                      ));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              height: 120,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: ForcastHoursByThreeStep().length,
                                  itemBuilder: (context, index){
                                    if(index == 0)
                                    {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Container(
                                          height: 100,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: foregroundColor,
                                            borderRadius: BorderRadius.circular(19),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Maintenant",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
                                              ),
                                              Image.asset(
                                                height: 40,
                                                '$iconBasePath/${ForcastHoursByThreeStep()[index]['icon']}.png',
                                              ),
                                              Text(
                                                '${meteo?.temperature.round()}°',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Container(
                                        height: 100,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: foregroundColor,
                                          borderRadius: BorderRadius.circular(19),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              ForcastHoursByThreeStep()[index]['datetime'].substring(0, 5),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Image.asset(
                                              height: 40,
                                              'assets/weatherIcons/${ForcastHoursByThreeStep()[index]['icon']}.png',
                                            ),
                                            Text(
                                              '${ForcastHoursByThreeStep()?[index]['temp'].round()}°',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                  }
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                          height: 30
                      ),
                      Visibility(
                        visible: autresVilles.length > 1,
                        child: SizedBox(
                          width: 400,
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Autres villes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 17),
                                    ),
                                  ),

                                ],
                              ),
                              Container(
                                height: 80,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: autresVilles.length,
                                    itemBuilder: (context, index)
                                    {
                                      final cityName = autresVilles[index].cityName;
                                      final cityIcone = autresVilles[index].icon;
                                      final cityTemperature = autresVilles[index].temperature;
                                      _visibility = cityName != meteo?.cityName;
                                      return Visibility(
                                        visible: _visibility,
                                        child: GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 15),
                                              child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: foregroundColor,
                                                  borderRadius: BorderRadius.circular(19),
                                                ),
                                                // ignore: prefer_const_constructors
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 10, left: 5),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 8.0),
                                                        child: Image.asset(
                                                          'assets/weatherIcons/$cityIcone.png',
                                                          height: 40
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            cityName,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.white),
                                                          ),
                                                          Text(
                                                            '${cityTemperature.round()}°C',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.white),
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              print("Hello");
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return DetailVille(autresVilles: autresVilles, meteo: autresVilles[index],);
                                              },)
                                              );
                                            }
                                        ),
                                      );

                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}


