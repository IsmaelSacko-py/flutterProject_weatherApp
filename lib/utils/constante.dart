//import 'dart:ui';

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parallax_rain/parallax_rain.dart';

// final Color backgroundColor = Color(0xff5842A9);
final Color foregroundColor = Colors.black26;
final Color textColor = Colors.white;
final String iconBasePath = "assets/weatherIcons";
final String imageBasePath = "assets/images";


final Set<String> listeMessages = {
  "Nous téléchargeons les données...",
  "C'est presque fini...",
  "Plus que quelques secondes avant d’avoir le résultat..."
};

