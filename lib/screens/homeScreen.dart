import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject_applicationmeteo/screens/forecast.dart';
import 'package:flutterproject_applicationmeteo/screens/loadCitiesScreen.dart';
import 'package:flutterproject_applicationmeteo/screens/selectVille.dart';
import 'package:flutterproject_applicationmeteo/utils/constante.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'dart:math';

import 'detailVilleScreen.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final Key parallaxThree = GlobalKey();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
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
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Image(
                    height: 400,
                    width: 400,
                    image: AssetImage(
                      '$imageBasePath/homePageImage.png',
                    )
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                    backgroundColor: MaterialStatePropertyAll(foregroundColor),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectVilles()),
                    );
                  },
                  // icon: Image(
                  //     width: 20,
                  //     image: AssetImage(
                  //         "assets/icons/app1.png"
                  //     )
                  // ),
                  icon: const Icon(Icons.ac_unit_sharp),
                  label: const Text(
                    "Commencer",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ]
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
