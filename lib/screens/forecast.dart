import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import '../models/meteo.dart';
import '../utils/constante.dart';

class Forecast extends StatefulWidget {
  Meteo? meteo;
  Forecast({super.key, required this.meteo});

  @override
  State<Forecast> createState() => _ForecastState();
}

List<String> items = List<String>.filled(10, '');

class _ForecastState extends State<Forecast> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Intl.defaultLocale = 'fr';
  }
  @override
  Widget build(BuildContext context) {
    final forecast = widget.meteo;
    final tommorowPrevisions = forecast?.days[1];
    // Donne les previsions des jours qui suivent demain
    final forecastSublist = forecast?.days.sublist(2);

    return Scaffold(

      appBar: AppBar(
        // surfaceTintColor: Colors.black54,
        // backgroundColor: foregroundColor,
        // iconTheme: const IconThemeData(color: Colors.white),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(300),
        //   child: Padding(
        //     padding: EdgeInsets.only(bottom: 80),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             Padding(
        //               padding: EdgeInsets.only(right: 50),
        //               child: Icon(Icons.ac_unit, color: Colors.white,),
        //             ),
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                     "Demain",
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 20,
        //                     )
        //                 ),
        //                 Text(
        //                     "25°",
        //                     style: TextStyle(
        //                         color: Colors.white,
        //                         fontSize: 34,
        //                         fontWeight: FontWeight.bold
        //                     )
        //                 ),
        //                 Text(
        //                     "mainCondition",
        //                     style: TextStyle(
        //                         color: Colors.white,
        //                         fontSize: 20
        //                     )
        //                 ),
        //
        //               ],
        //             )
        //           ],
        //         ),
        //         Padding(
        //           padding: EdgeInsets.only(top: 30),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //             children: [
        //               Padding(
        //                 padding: EdgeInsets.only(left: 8),
        //                 child: Column(
        //                   children: [
        //                     Padding(padding: EdgeInsets.only(top: 15)),
        //                     Icon(Icons.remove_red_eye_outlined, color: Colors.white),
        //                     Text(
        //                       '${forecast?.visibility.round()} km',
        //                       style: const TextStyle(
        //                           fontSize: 15,
        //                           fontWeight: FontWeight.w500,
        //                           color: Colors.white
        //                       ),
        //                     ),
        //                     Text(
        //                       'Visibilité',
        //                       style:
        //                       TextStyle(
        //                           fontSize: 15,
        //                           color: Colors.white
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               Padding(
        //                 padding: EdgeInsets.only(left: 8),
        //                 child: Column(
        //                   children: [
        //                     Image(
        //                         height: 40,
        //                         image: AssetImage(
        //                           'assets/icons/gouteEau.png',
        //                         )),
        //                     Text(
        //                       '${forecast?.humidity.round()}%',
        //                       style: TextStyle(
        //                           fontSize: 15,
        //                           fontWeight: FontWeight.w500,
        //                           color: Colors.white),
        //                     ),
        //                     Text(
        //                       'Humidité',
        //                       style:
        //                       TextStyle(fontSize: 15, color: Colors.white),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               Padding(
        //                 padding: EdgeInsets.only(right: 8),
        //                 child: Column(
        //                   children: [
        //                     Image(
        //                         height: 40,
        //                         image: AssetImage(
        //                           'assets/icons/vent.png',
        //                         )),
        //                     Text(
        //                       '${forecast?.windSpeed.round()} km/h',
        //                       style: TextStyle(
        //                           fontSize: 15,
        //                           fontWeight: FontWeight.w500,
        //                           color: Colors.white),
        //                     ),
        //                     Text(
        //                       'Vitesse du vent',
        //                       style:
        //                       TextStyle(fontSize: 15, color: Colors.white),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(50),
        //       bottomRight: Radius.circular(50)
        //   )
        // ),
        // backgroundColor: const Color(0xff5842A9),
        backgroundColor: foregroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    foregroundDecoration: BoxDecoration(
                      color: foregroundColor,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Image.asset(
                                  "$iconBasePath/${tommorowPrevisions['icon']}.png",
                                  height: 140,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Demain",
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                      )
                                  ),
                                  Text(
                                      "${tommorowPrevisions['temp'].round()}°",
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                        utf8.decode(tommorowPrevisions['conditions'].codeUnits),
                                        //"${tommorowPrevisions['conditions']}",
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: 20
                                        ),
                                      softWrap: true,
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Padding(padding: EdgeInsets.only(top: 15)),
                                    Image(
                                        height: 40,
                                        image: AssetImage(
                                          'assets/icons/visibility.png',
                                        )
                                    ),
                                    Text(
                                      '${tommorowPrevisions['visibility'].round()} km',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: textColor
                                      ),
                                    ),
                                    Text(
                                      'Visibilité',
                                      style:
                                      TextStyle(
                                          fontSize: 15,
                                          color: textColor
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      height: 50,
                                      'assets/icons/humidity.svg',
                                    ),
                                    Text(
                                      '${tommorowPrevisions['humidity'].round()}%',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: textColor),
                                    ),
                                    Text(
                                      'Humidité',
                                      style:
                                      TextStyle(fontSize: 15, color: textColor),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Image(
                                        height: 50,
                                        image: AssetImage(
                                          'assets/icons/vent.png',
                                        )),
                                    Text(
                                      '${tommorowPrevisions['windspeed'].round()} km/h',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: textColor),
                                    ),
                                    Text(
                                      'Vent',
                                      style:
                                      TextStyle(fontSize: 15, color: textColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: ListView.builder(
                        itemCount: forecastSublist?.length,
                        itemBuilder: (context, index){
                          print("nb jours ${forecastSublist?.length}");
                          final meteo = forecastSublist?[index];
                          final date = DateTime.parse(meteo['datetime']);
                          //final day = DateFormat.E('fr');
                          final jour = DateFormat.E().format(date);
                          return Container(
                            height: 70,
                            // decoration: BoxDecoration(
                            //   color: foregroundColor,
                            // ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                          jour,
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 16,
                                          )
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                            child: Image.asset(
                                              "$iconBasePath/${meteo['icon']}.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Text(
                                              utf8.decode(meteo['conditions'].codeUnits),
                                              //'${meteo['conditions']}',
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize: 16,
                                              ),
                                              softWrap: true
                                          ),

                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                          "${meteo['tempmax'].round()}°",
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 18,
                                            fontWeight: FontWeight.w700
                                          )
                                      ),
                                    ),
                                    Text(
                                        "${meteo['tempmin'].round()}°",
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: 14
                                        )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },

                      ),
                    ),
                  ),
                    
                ]
            ),
          ],
        ),
      ),
      // body: Stack(
      //   children: [
      //     ImageFiltered(
      //       imageFilter: ImageFilter.blur(
      //         sigmaX: 30,
      //         sigmaY: 30,
      //       ),
      //       child: Image(
      //         image: AssetImage(
      //           '$imageBasePath/appBg.png',
      //         ),
      //         height: MediaQuery.of(context).size.height,
      //         width: MediaQuery.of(context).size.width,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     CustomScrollView(
      //       //physics: const ClampingScrollPhysics(),
      //       slivers: [
      //         SliverAppBar(
      //           // leading: IconButton(
      //           //   onPressed: () {  },
      //           //   icon: Icon(Icons.arrow_back),
      //           //
      //           // ),
      //           expandedHeight: 300,
      //           backgroundColor: foregroundColor,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(50),
      //                 bottomRight: Radius.circular(50)
      //             )
      //           ),
      //           pinned: true,
      //           // flexibleSpace: FlexibleSpaceBar(
      //           //   background: DecoratedBox(
      //           //     decoration: BoxDecoration(
      //           //       borderRadius: BorderRadius.only(
      //           //         bottomRight: Radius.circular(20),
      //           //         bottomLeft: Radius.circular(20)
      //           //       )
      //           //
      //           //     ),
      //           //
      //           //   ),
      //           // ),
      //         ),
      //         // SliverToBoxAdapter(
      //         //   child: ListView.builder(
      //         //     itemCount: forecast?.days.length,
      //         //     itemBuilder: (context, index){
      //         //       return Container(
      //         //         height: 70,
      //         //         // decoration: BoxDecoration(
      //         //         //   color: foregroundColor,
      //         //         // ),
      //         //         child: Row(
      //         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         //           children: [
      //         //             Container(
      //         //               child: Row(
      //         //                 children: [
      //         //                   Padding(
      //         //                     padding: const EdgeInsets.only(right: 40),
      //         //                     child: Text(
      //         //                         'Sam${index}',
      //         //                         style: TextStyle(
      //         //                           color: Colors.white,
      //         //                           fontSize: 16,
      //         //                         )
      //         //                     ),
      //         //                   ),
      //         //                   Row(
      //         //                     children: [
      //         //                       Padding(
      //         //                         padding: const EdgeInsets.only(right: 10),
      //         //                         child: Icon(Icons.ac_unit_sharp),
      //         //                       ),
      //         //                       Text(
      //         //                           'mainConditions',
      //         //                           style: TextStyle(
      //         //                             color: Colors.white,
      //         //                             fontSize: 16,
      //         //                           )
      //         //                       )
      //         //                     ],
      //         //                   ),
      //         //                 ],
      //         //               ),
      //         //             ),
      //         //             Row(
      //         //               children: [
      //         //                 Padding(
      //         //                   padding: const EdgeInsets.only(right: 20),
      //         //                   child: Text(
      //         //                       "23°",
      //         //                       style: TextStyle(
      //         //                           color: Colors.white,
      //         //                           fontSize: 20
      //         //                       )
      //         //                   ),
      //         //                 ),
      //         //                 Text(
      //         //                     "23°",
      //         //                     style: TextStyle(
      //         //                         color: Colors.white,
      //         //                         fontSize: 20
      //         //                     )
      //         //                 )
      //         //               ],
      //         //             ),
      //         //           ],
      //         //         ),
      //         //       );
      //         //     }
      //         //   ),
      //         // ),
      //         SliverToBoxAdapter(
      //           child: Column(
      //               children: [
      //                 // Container(
      //                 //   height: 280,
      //                 //   width: 380,
      //                 //   decoration: BoxDecoration(
      //                 //       color: const Color(0xff331C71),
      //                 //       borderRadius: BorderRadius.circular(16)
      //                 //   ),
      //                 //   child: const Column(
      //                 //     mainAxisAlignment: MainAxisAlignment.center,
      //                 //     children: [
      //                 //       Row(
      //                 //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 //         children: [
      //                 //           Padding(
      //                 //             padding: EdgeInsets.only(right: 50),
      //                 //             child: Icon(Icons.ac_unit),
      //                 //           ),
      //                 //           Column(
      //                 //             crossAxisAlignment: CrossAxisAlignment.start,
      //                 //             children: [
      //                 //               Text(
      //                 //                   "Demain",
      //                 //                   style: TextStyle(
      //                 //                     color: Colors.white,
      //                 //                     fontSize: 20,
      //                 //                   )
      //                 //               ),
      //                 //               Text(
      //                 //                   "25°",
      //                 //                   style: TextStyle(
      //                 //                       color: Colors.white,
      //                 //                       fontSize: 34,
      //                 //                       fontWeight: FontWeight.bold
      //                 //                   )
      //                 //               ),
      //                 //               Text(
      //                 //                   "mainCondition",
      //                 //                   style: TextStyle(
      //                 //                       color: Colors.white,
      //                 //                       fontSize: 20
      //                 //                   )
      //                 //               ),
      //                 //
      //                 //             ],
      //                 //           )
      //                 //         ],
      //                 //       ),
      //                 //       Padding(
      //                 //         padding: EdgeInsets.only(top: 40),
      //                 //         child: Row(
      //                 //           mainAxisAlignment: MainAxisAlignment.center,
      //                 //           children: [
      //                 //             Padding(
      //                 //               padding: EdgeInsets.only(right: 40),
      //                 //               child: Column(
      //                 //                 children: [
      //                 //                   Padding(padding: EdgeInsets.only(top: 15)),
      //                 //                   Icon(Icons.remove_red_eye_outlined, color: Colors.white),
      //                 //                   Text(
      //                 //                     '10',
      //                 //                     style: TextStyle(
      //                 //                         fontSize: 12,
      //                 //                         fontWeight: FontWeight.bold,
      //                 //                         color: Colors.white),
      //                 //                   ),
      //                 //                   Text(
      //                 //                     'Visibilité',
      //                 //                     style:
      //                 //                     TextStyle(fontSize: 12, color: Colors.white),
      //                 //                   ),
      //                 //                 ],
      //                 //               ),
      //                 //             ),
      //                 //             Padding(
      //                 //               padding: EdgeInsets.only(right: 40),
      //                 //               child: Column(
      //                 //                 children: [
      //                 //                   Image(
      //                 //                       height: 40,
      //                 //                       image: AssetImage(
      //                 //                         'assets/icons/gouteEau.png',
      //                 //                       )),
      //                 //                   Text(
      //                 //                     'hun=midity',
      //                 //                     style: TextStyle(
      //                 //                         fontSize: 12,
      //                 //                         fontWeight: FontWeight.bold,
      //                 //                         color: Colors.white),
      //                 //                   ),
      //                 //                   Text(
      //                 //                     'Humidité',
      //                 //                     style:
      //                 //                     TextStyle(fontSize: 12, color: Colors.white),
      //                 //                   ),
      //                 //                 ],
      //                 //               ),
      //                 //             ),
      //                 //             Column(
      //                 //               children: [
      //                 //                 Image(
      //                 //                     height: 40,
      //                 //                     image: AssetImage(
      //                 //                       'assets/icons/vent.png',
      //                 //                     )),
      //                 //                 Text(
      //                 //                   '9km',
      //                 //                   style: TextStyle(
      //                 //                       fontSize: 12,
      //                 //                       fontWeight: FontWeight.bold,
      //                 //                       color: Colors.white),
      //                 //                 ),
      //                 //                 Text(
      //                 //                   'Vitesse du vent',
      //                 //                   style:
      //                 //                   TextStyle(fontSize: 12, color: Colors.white),
      //                 //                 ),
      //                 //               ],
      //                 //             ),
      //                 //           ],
      //                 //         ),
      //                 //       ),
      //                 //     ],
      //                 //   ),
      //                 // ),
      //                 //const Padding(padding: EdgeInsets.only(top: 10)),
      //
      //                 ListView.builder(
      //                   shrinkWrap: true,
      //                   physics: ClampingScrollPhysics(),
      //                   itemCount: 30,
      //                   itemBuilder: (context, index){
      //                     return Container(
      //                       height: 70,
      //                       // decoration: BoxDecoration(
      //                       //   color: foregroundColor,
      //                       // ),
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Container(
      //                             child: Row(
      //                               children: [
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(right: 40),
      //                                   child: Text(
      //                                       'Sam${index}',
      //                                       style: TextStyle(
      //                                         color: Colors.white,
      //                                         fontSize: 16,
      //                                       )
      //                                   ),
      //                                 ),
      //                                 Row(
      //                                   children: [
      //                                     Padding(
      //                                       padding: const EdgeInsets.only(right: 10),
      //                                       child: Icon(Icons.ac_unit_sharp),
      //                                     ),
      //                                     Text(
      //                                         'mainConditions',
      //                                         style: TextStyle(
      //                                           color: Colors.white,
      //                                           fontSize: 16,
      //                                         )
      //                                     )
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           Row(
      //                             children: [
      //                               Padding(
      //                                 padding: const EdgeInsets.only(right: 20),
      //                                 child: Text(
      //                                     "23°",
      //                                     style: TextStyle(
      //                                         color: Colors.white,
      //                                         fontSize: 20
      //                                     )
      //                                 ),
      //                               ),
      //                               Text(
      //                                   "23°",
      //                                   style: TextStyle(
      //                                       color: Colors.white,
      //                                       fontSize: 20
      //                                   )
      //                               )
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                     );
      //                   },
      //
      //                 ),
      //
      //               ]
      //           ),
      //         ),
      //         // SliverList(
      //         //   delegate: SliverChildBuilderDelegate(
      //         //
      //         //     (context, index){
      //         //       return Container(
      //         //         height: 70,
      //         //         // decoration: BoxDecoration(
      //         //         //   color: foregroundColor,
      //         //         // ),
      //         //         child: Row(
      //         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         //           children: [
      //         //             Container(
      //         //               child: Row(
      //         //                 children: [
      //         //                   Padding(
      //         //                     padding: const EdgeInsets.only(right: 40),
      //         //                     child: Text(
      //         //                         'Sam${index}',
      //         //                         style: TextStyle(
      //         //                           color: Colors.white,
      //         //                           fontSize: 16,
      //         //                         )
      //         //                     ),
      //         //                   ),
      //         //                   Row(
      //         //                     children: [
      //         //                       Padding(
      //         //                         padding: const EdgeInsets.only(right: 10),
      //         //                         child: Icon(Icons.ac_unit_sharp),
      //         //                       ),
      //         //                       Text(
      //         //                           'mainConditions',
      //         //                           style: TextStyle(
      //         //                             color: Colors.white,
      //         //                             fontSize: 16,
      //         //                           )
      //         //                       )
      //         //                     ],
      //         //                   ),
      //         //                 ],
      //         //               ),
      //         //             ),
      //         //             Row(
      //         //               children: [
      //         //                 Padding(
      //         //                   padding: const EdgeInsets.only(right: 20),
      //         //                   child: Text(
      //         //                       "23°",
      //         //                       style: TextStyle(
      //         //                           color: Colors.white,
      //         //                           fontSize: 20
      //         //                       )
      //         //                   ),
      //         //                 ),
      //         //                 Text(
      //         //                     "23°",
      //         //                     style: TextStyle(
      //         //                         color: Colors.white,
      //         //                         fontSize: 20
      //         //                     )
      //         //                 )
      //         //               ],
      //         //             ),
      //         //           ],
      //         //         ),
      //         //       );
      //         //     },
      //         //     childCount: 30,
      //         //   ),
      //         // )
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}
