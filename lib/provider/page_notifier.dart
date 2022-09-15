import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/pages/auth/auth_page.dart';
import 'package:front_nearby_caregiver/pages/calendar/calendar_page.dart';
import 'package:front_nearby_caregiver/data/user.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

import 'package:intl/intl.dart';

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

  late String _selectedDate = DateTime.now().toString();
  String get selectedDate => _selectedDate;

  void set(DateTime date){
      _selectedDate = DateFormat('yyyy-MM-dd').format(date);
      notifyListeners();
  }

  List<UserOA> _elderlyList = [];
  List<UserOA> get elderlyList => _elderlyList;


  void setList(List<UserOA> list){
    _elderlyList = list;
    notifyListeners();
  }

  UserOA _selectedElderly = UserOA(elderlyId: 'test', cgEmail: 'test', elderlyName: 'test', phoneNumber: 'test');
  UserOA get selectedElderly => _selectedElderly;
  void setElderly(UserOA elderly){
      _selectedElderly = elderly;
      notifyListeners();
  }
}