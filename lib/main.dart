import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/pages/auth/permission_record_page.dart';
import 'package:front_nearby_caregiver/pages/auth/register_oa_page.dart';
import 'package:front_nearby_caregiver/pages/calendar/add_calendar_page.dart';
import 'package:front_nearby_caregiver/pages/auth/auth_page.dart';
import 'package:front_nearby_caregiver/pages/calendar/calendar_page.dart';
import 'package:front_nearby_caregiver/pages/chatting/chatting_page.dart';
import 'package:front_nearby_caregiver/pages/auth/record_page.dart';
import 'package:front_nearby_caregiver/pages/home_page.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';
import 'package:front_nearby_caregiver/provider/page_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=>PageNotifier())],
      child: MaterialApp(
        title: 'Nearby project elderly.ver',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Palette.newBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<PageNotifier>(
          builder: (context, pageNotifier, child){
            return Navigator(
              pages:[
                MaterialPage(
                    key: ValueKey(HomePage.pageName),
                    child: HomePage()),
                if(pageNotifier.currentPage == CalendarPage.pageName)
                  CalendarPage(),
                if(pageNotifier.currentPage == AuthPage.pageName)
                  AuthPage(),
                if(pageNotifier.currentPage == ChattingPage.pageName)
                  ChattingPage(),
                if(pageNotifier.currentPage == AddCalendarPage.pageName)
                  AddCalendarPage(),
                if(pageNotifier.currentPage == RecordPage.pageName)
                  RecordPage(),
                if(pageNotifier.currentPage == PermissionRecordPage.pageName)
                  PermissionRecordPage(),
                if(pageNotifier.currentPage == RegisterOAPage.pageName)
                  RegisterOAPage(),
              ],
              onPopPage: (route, result){
                if(!route.didPop(result)){
                  return false;
                }
                return true;
              },
            );
          },
        ),
      ),
    );
  }
}


