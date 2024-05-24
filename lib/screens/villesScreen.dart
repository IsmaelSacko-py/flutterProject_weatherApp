import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterproject_applicationmeteo/screens/detailVilleScreen.dart';
import 'package:flutterproject_applicationmeteo/screens/selectVille.dart';
import 'package:flutterproject_applicationmeteo/utils/constante.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:animated_list_item/animated_list_item.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'package:animations/animations.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/meteo.dart';
import '../utils/constante.dart';
import 'loadCitiesScreen.dart';

class VillesPage extends StatefulWidget {
  final List<Meteo> listVilles;

  const VillesPage({
    required this.listVilles,
    Key? key,
  }) : super(key: key);

  @override
  _VillesPageState createState() => _VillesPageState();
}

class _VillesPageState extends State<VillesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isVisible = true;
  ButtonState stateTextWithIcon = ButtonState.idle;
  Meteo? _meteo;



  Padding item(List<Meteo> listeVilles, int index) {
    Meteo? meteo = listeVilles[index];
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: OpenContainer(
        openColor: Colors.transparent,
        closedColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 2000),
        closedBuilder: (context, openWidget) {
          return Container(
            height: 80,
            decoration: BoxDecoration(
              color: foregroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image.asset(
                          "$iconBasePath/${meteo.icon}.png",
                          height: 40,
                          width: 40,
                        )
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${meteo.temperature.round()}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Text(
                            utf8.decode((meteo.mainCondition).codeUnits),
                            //meteo.mainCondition,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            meteo.cityName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                            )
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        openBuilder: (context, closeWidget) {
          // meteo: meteo, autresVilles: listeVilles
          return DetailVille(meteo: meteo, autresVilles: listeVilles);
        },
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState()
  //   ;
  //   _animationController = AnimationController(
  //     duration: const Duration(milliseconds: 2000),
  //     vsync: this,
  //   );
  //   _animationController.forward();
  // }

  Set<String> listeMessages = {
    "Nous telechargeons les donnees...",
    "C'est presque fini...",
    "Plus que quelques secondes avant d’avoir le résultat…"
  };
  int currentStep = 0;
  late Timer _timer;
  int pourcentage = 0;
  final Key parallaxThree = GlobalKey();


  @override
  void initState() {
    super.initState();
    //_fetchMeteo();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animationController.forward();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onPressedIconWithText() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
            _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
              setState(() {
                SelectVilles.VillesSelectionnees.clear();

                _timer.cancel();
                // Annulez le Timer lorsque l'état est supprimé pour éviter les fuites de mémoire
                //super.dispose();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const SelectVilles()),
                );

              });
            });
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;

        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ListVilles = widget.listVilles;
    return Scaffold(
      backgroundColor: const Color(0xff5842A9),
      body: Stack(
        children: [
          Stack(
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
              Transform.rotate(
                angle: pi / 10,
                child: ParallaxRain(
                  key: parallaxThree,
                  dropColors: const [Colors.white],
                  numberOfDrops: 50,
                  trail: true,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: ListVilles.length,
                      itemBuilder: (context, index) {
                        final ville = ListVilles[index];
                        //_meteo = ville.getMeteo() as Meteo?;
                        return AnimatedListItem(
                          index: index,
                          length: ListVilles.length,
                          aniController: _animationController,
                          animationType: AnimationType.slide,
                          startX: 40,
                          startY: 60,
                          child: item(ListVilles, index),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(children: [
                      Visibility(
                        visible: _isVisible,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                listeMessages.elementAt(listeMessages.length - 1),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            LinearPercentIndicator(
                              lineHeight: 30.0,
                              barRadius: const Radius.circular(10),
                              percent: 1,
                              center: const Text("100%", style: TextStyle(color: Colors.white, fontSize: 16),),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.teal,
                              backgroundColor: foregroundColor,
                            ),
                          ],
                        ),
                      ),


                    ]),
                  ),
                ]),
          )
        ]
      ),
      floatingActionButton: Visibility(
        visible: !_isVisible,
        child: FloatingActionButton(
          onPressed: (){

          },
          backgroundColor: Colors.transparent,
          //tooltip: 'Increment',
          child: ProgressButton.icon(
              iconedButtons: {
                ButtonState.idle: IconedButton(
                    //text: "Recommencer",
                    icon: Icon(Icons.replay_outlined,
                        color: Colors.white),
                    color: foregroundColor),
                ButtonState.loading: IconedButton(
                    //text: "Chargement",
                    color: foregroundColor),
                // ButtonState.fail: IconedButton(
                //     text: "Failed",
                //     icon: Icon(Icons.cancel, color: Colors.white),
                //     color: Colors.red.shade300),
                ButtonState.fail: IconedButton(
                    //text: "Reussie",
                    icon: const Icon(
                      Icons.check_outlined,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400),
                ButtonState.success: IconedButton(
                    //text: "Reussie",
                    icon: const Icon(
                      Icons.check_outlined,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400)
              },
              onPressed: onPressedIconWithText,
              state: stateTextWithIcon),
        ),
      ), //
    );
  }
}


