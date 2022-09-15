import '../init.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'getCalendar.dart';

void setCalendar(elderlyId, date, content) async {
  var url = Uri.https(urlString, '/calandar/schedule/oneoff');
  print('{"elderly_id": $elderlyId, "date":, "content": $content}');
  final response = await http.post(url,
      body:
      {
        "elderly_id": elderlyId,
        "date": DateFormat('yyyy-MM-dd HH:mm').format(date),
        "content": content
      });
  getCalendar(elderlyId);
  print(response.body);
}