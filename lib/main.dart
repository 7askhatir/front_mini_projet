import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_projet/service/DevicesService.dart';
import 'package:mini_projet/service/ReferenceService.dart';
import 'package:mini_projet/service/SensorService.dart';
import 'package:mini_projet/views/Sensors-list.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  SensorsList(),
    );
  }

}

