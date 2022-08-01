import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/pages/auth_page.dart';
import 'package:front_nearby_caregiver/pages/chat_page.dart';
import 'package:front_nearby_caregiver/pages/calendar_page.dart';

class PageNotifier extends ChangeNotifier{
  String _currentPage = AuthPage.pageName;

  String get currentPage => _currentPage;

  void goToMain()
  {
    _currentPage = CalendarPage.pageName;
    notifyListeners();
  }

  void goToOtherPage(String name)
  {
    _currentPage = name;
    notifyListeners();
  }

}