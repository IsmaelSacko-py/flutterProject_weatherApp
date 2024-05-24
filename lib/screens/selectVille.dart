import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterproject_applicationmeteo/screens/loadCitiesScreen.dart';
import 'package:flutterproject_applicationmeteo/utils/constante.dart';

class SelectVilles extends StatefulWidget {
  static final List<String> VillesSelectionnees = [];
  const SelectVilles({super.key});

  @override
  State<SelectVilles> createState() => _SelectVillesState();
}

class _SelectVillesState extends State<SelectVilles> {

  List<Map> villes = [
    {"name": "Dakar", "isChecked": false},
    {"name": "Banjul", "isChecked": false},
    {"name": "Paris", "isChecked": false},
    {"name": "Rome", "isChecked": false},
    {"name": "Cotonou ", "isChecked": false},
    {"name": "Libreville ", "isChecked": false},
    {"name": "Franceville ", "isChecked": false},
    {"name": "Tunis ", "isChecked": false},
    {"name": "Marrakech ", "isChecked": false},
    {"name": "Miami ", "isChecked": false},
    {"name": "Bamako ", "isChecked": false},
    {"name": "Kinshasa ", "isChecked": false},
    {"name": "Douala ", "isChecked": false},
  ];

  late bool _visibility = false;

  //List<String> VillesSelectionnees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // extendBody: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Visibility(
            visible: _visibility,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(foregroundColor),
              ),
              child: const Text(
                "Continuer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoadCitiesPage()),
                );
              },
            ),
          ),
        ),
        ]
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Stack(children: [
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Selectionner les villes :",
                style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      children: villes.map((favorite) {
                    return CheckboxListTile(
                        side: const BorderSide(
                          color: Colors.white54,
                          width: 1.5,
                        ),
                        activeColor: Colors.white70,
                        checkColor: Colors.black,
                        // checkboxShape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(5)),
                        value: favorite["isChecked"],
                        title: Text(
                          favorite["name"],
                          style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        onChanged: (val) {
                          setState(() {
                            favorite["isChecked"] = val;
                            if (val == true)
                              SelectVilles.VillesSelectionnees.add(
                                  favorite["name"]);
                            else
                              SelectVilles.VillesSelectionnees.remove(
                                  favorite["name"]);

                            _visibility =
                                SelectVilles.VillesSelectionnees.isNotEmpty;
                          });
                        });
                  }).toList()),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Wrap(
                children: villes.map((favorite) {
                  if (favorite["isChecked"] == true) {
                    return Card(
                      elevation: 3,
                      color: foregroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              favorite["name"],
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  favorite["isChecked"] =
                                      !favorite["isChecked"];
                                });
                              },
                              child: const Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }).toList(),
              )
            ]),
          ]),
        ),
      ),
    );
  }
}
