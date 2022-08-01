import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';
import '../component/calendar_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("어르신",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Palette.newBlue,
            )),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          CalendarBox(),
          const SizedBox(
            width: 0.8,
          ),
        ],
      ),
    );
  }
}
