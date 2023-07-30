// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:task2/home.dart';
import 'package:task2/results.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home',
    routes: {
      'home' : (context) => MyHome(),
      'result': (context)=> MyResult()
    },
  ));
}

