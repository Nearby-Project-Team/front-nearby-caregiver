import 'dart:convert';

import '../../data/calendar.dart';
import '../init.dart';
import 'package:http/http.dart' as http;

Future<CalendarUser> getCalendar(elderlyId) async {
  var url = Uri.https(urlString, '/elderly/calender/all', {"elderly_id": elderlyId});
  print(elderlyId);

  final response = await http.get(url);
  final list = json.decode(response.body);
  return CalendarUser.fromJson(list, elderlyId);
}