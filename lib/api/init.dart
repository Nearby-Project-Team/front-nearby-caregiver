import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../data/user.dart';

const String urlString = 'api-test.nearbycrew.com:8443';

User _userCaregiver = User(
    userId: "test",
    name: "test",
    email: "test",
    phoneNumber: "test",
    elderlyList: []
);

void setUser (User user) async{
  _userCaregiver = user;
}

void setElderlyList (List<UserOA> list) async{
  _userCaregiver.elderlyList = list;
}

void setUserEmail (String email) async{
  _userCaregiver.email = email;
}

User getUser() {
  return _userCaregiver;
}

String getUserID() {
  return _userCaregiver.userId;
}

String getUserName() {
  return _userCaregiver.name;
}

String getUserEmail() {
  return _userCaregiver.email;
}

List<UserOA>? getElderlyList() {
  if(_userCaregiver.elderlyList == null) {
    return [];
  }
  return _userCaregiver.elderlyList;
}

// 서버 연결 확인을 위한 method
void testMain() async {
  var url = Uri.https(urlString, "/auth/agreement");
  var response = await http.post(url, body: {"email" : "kimh060612@khu.ac.kr"});
  //print(response.body.toString());
}