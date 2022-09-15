import 'dart:convert';

import '../../data/user.dart';
import '../init.dart';
import 'package:http/http.dart' as http;

import 'getOAList.dart';

Future<List<UserOA>> registerOA(email, name, birthday, phoneNumber) async {
  var url = Uri.https(urlString, '/elderly/register');
  final response = await http.post(url, body: {
    'email': email,
    'name': name,
    'birthdate': birthday,
    'phone_number': phoneNumber,
    'agreement': 'Y'
  });

  final result = json.decode(response.body);
  print(result.toString());

  final OAList = await getOAList(email);
  var list = OAList['data'] as List;
  final elderlyList = list.map((i) => UserOA.fromJson(i)).toList();



  return elderlyList;
}