import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutterproject_applicationmeteo/screens/detailVilleScreen.dart';
import 'package:flutterproject_applicationmeteo/screens/selectVille.dart';
import 'package:flutterproject_applicationmeteo/screens/villesScreen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutterproject_applicationmeteo/models/ville.dart';
import 'package:animated_list_item/animated_list_item.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'package:animations/animations.dart';
import 'package:http/http.dart' as http;

import '../models/meteo.dart';
import '../utils/constante.dart';

class LoadCitiesPage extends StatefulWidget {

  LoadCitiesPage({Key? key}) : super(key: key);

  @override
  _LoadCitiesPageState createState() => _LoadCitiesPageState();
}

class _LoadCitiesPageState extends State<LoadCitiesPage>
    with SingleTickerProviderStateMixin {
  late List<Meteo> ListVilles;
  bool _isVisible = false;
  String apiKey = "ce0ca1a2cec0a0e11b560dca2c4a0934";





  int currentStep = 0;
  late Timer _timer1;
  late Timer _timer2;
  int pourcentage = 0;
  final Key parallaxThree = GlobalKey();

  int timerInterval = 2;
  // Correspond a la durée de l'animation du LinearPercentIndicator
  final dureeAnimation = 1000 + SelectVilles.VillesSelectionnees.length * 5000;

  // Temps ecoule depuis le debut du chargement
  int tempsEcoule = 0;
  double _progress = 0.0;
  double _progressStep = 1/SelectVilles.VillesSelectionnees.length;
  //late final meteo;

  Future<Meteo> fetchData(String cityName) async {
    // Effectuer un travail asynchrone
    Ville ville = Ville(cityName);
    final meteo = await ville.getMeteo();
    return meteo;
  }
  @override
  void initState() {
    super.initState();
    ListVilles = [];


    int counter = 0;
    int index = 0;
    int nombreVillesSelectionnees = SelectVilles.VillesSelectionnees.length;
    print(nombreVillesSelectionnees);

    // _timer1 = Timer.periodic(Duration(seconds: nombreVillesSelectionnees), (timer){
    //   _progress += 1/nombreVillesSelectionnees;
    // });
    _timer2 = Timer.periodic(const Duration(seconds: 5), (timer) {
      print("index : 1");
      String cityName = SelectVilles.VillesSelectionnees.elementAt(index);

      fetchData(cityName).then((meteo) {
        // Mettre à jour l'état dans setState une fois que fetchData est terminé
        setState(() {
          ListVilles.add(meteo);
          print(meteo.cityName);
          print("Counter : $counter");
          if(counter == nombreVillesSelectionnees - 1)
            _timer2.cancel();

          counter+=5;
          index++;
          //_progress = (counter * 100 ) / nombreVillesSelectionnees;
          _progress = (index/nombreVillesSelectionnees);
          (currentStep == listeMessages.length - 1) ? currentStep = 0 : currentStep++;
          print("currentStep : $currentStep");
          tempsEcoule += 5;
        });
      });
    });
  }







  @override
  void dispose() {
    // _timer1
    //     .cancel(); // Annulez le Timer lorsque l'état est supprimé pour éviter les fuites de mémoire
    _timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5842A9),
      body: Stack(children: [
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
        Stack(
          children: [
            Transform.rotate(
              angle: pi / 10,
              child: ParallaxRain(
                key: parallaxThree,
                dropColors: const [Colors.white],
                numberOfDrops: 50,
                trail: true,
              ),
            ),
            Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  listeMessages.elementAt(currentStep),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 30.0,
                    animationDuration: dureeAnimation,
                    barRadius: const Radius.circular(10),
                    percent: 1,
                    center: Text(
                      "${(_progress * 100).toStringAsFixed(0)}%",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.teal,
                    backgroundColor: foregroundColor,
                    onAnimationEnd: () {

                      //_timer1.cancel(); // Annulez le Timer lorsque l'état est supprimé pour éviter les fuites de mémoire
                      _timer2.cancel();
                      // _timer2 = Timer.periodic(const Duration(seconds: 2), (timer) {
                      //   _timer2.cancel();
                        // super.dispose();
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return VillesPage(listVilles: ListVilles);
                          },)
                        );
                      // });
                    },
                  ),
                ),
              ]),
            ),
          ],
        )
      ]),
    );
  }
}
