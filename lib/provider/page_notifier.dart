import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/pages/auth/auth_page.dart';
import 'package:front_nearby_caregiver/pages/home_page.dart';
import 'package:front_nearby_caregiver/pages/calendar/calendar_page.dart';
import 'package:intl/intl.dart';

class PageNotifier extends ChangeNotifier{
  String _currentPage = HomePage.pageName;
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

  late String _selectedDate = DateTime.now().toString();
  String get selectedDate => _selectedDate;

  void set(DateTime date){
      _selectedDate = DateFormat('yyyy-MM-dd').format(date);
      notifyListeners();
  }
}