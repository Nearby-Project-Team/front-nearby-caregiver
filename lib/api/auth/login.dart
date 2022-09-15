import 'dart:convert';

import '../../data/user.dart';
import '../elderly/getOAList.dart';
import '../init.dart';
import 'package:http/http.dart' as http;

void loginUser(email, password) async {
  var url = Uri.https(urlString, '/auth/login');
  final response = await http.post(url, body: {'email': email, 'password': password});

  final userMap = json.decode(response.body);
  final OAList = await getOAList(email);
  setUser(User.fromJson(userMap, OAList));
}