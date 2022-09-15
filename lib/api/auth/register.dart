import 'dart:convert';

import '../../data/user.dart';
import '../init.dart';
import 'package:http/http.dart' as http;

void registerUser(email, password, name, phoneNumber) async {
  var url = Uri.https(urlString, '/auth/register');
  final response = await http.post(url, body: {'email': email, 'password': password, 'name':name, 'phone_number': phoneNumber});

  final userMap = json.decode(response.body);

  setUser(User.fromJson(userMap, null));
}