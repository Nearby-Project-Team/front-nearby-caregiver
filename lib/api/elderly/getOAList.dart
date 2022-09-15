import 'dart:convert';

import '../init.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getOAList(email) async {
  var bytes = utf8.encode(email);
  var urlBase = base64Encode(bytes);
  print(urlBase);
  var url = Uri.https(urlString, '/elderly/list/$urlBase');

  final response = await http.get(url);
  final OAList = json.decode(response.body);

  return OAList;
}