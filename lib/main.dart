import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/pages/home_page.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nearby project caregiver.ver',
      theme: ThemeData(
        primarySwatch: Palette.newBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}