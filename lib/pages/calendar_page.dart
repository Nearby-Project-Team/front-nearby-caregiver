import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../provider/page_notifier.dart';
import 'auth_page.dart';

class CalendarPage extends StatefulWidget {
  static final String pageName = 'CalendarPage';

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  late DateTime selectedDay = DateTime.now();
  late List selectedEvent;

  final Map<DateTime, List<CleanCalendarEvent>> _events = {
  DateTime(2022,8,1): [
      CleanCalendarEvent('Event A',
          startTime: DateTime(2022,8,1, 10, 0),
          endTime: DateTime(2022,8,1, 12, 0),
          description: 'A special event',
          isDone: true
      ),
      CleanCalendarEvent('Event B',
        startTime: DateTime(2022,8,1, 13, 0),
        endTime: DateTime(2022,8,1, 16, 0),
        description: 'A special event',
        isDone: false
      ),
    ],
    DateTime(2022,8,2): [
      CleanCalendarEvent('Event C',
          startTime: DateTime(2022,8,2, 10, 0),
          endTime: DateTime(2022,8,2, 12, 0),
          description: 'A special event',
          isDone: true
      ),
      CleanCalendarEvent('Event D',
          startTime: DateTime(2022,8,2, 13, 0),
          endTime: DateTime(2022,8,2, 16, 0),
          description: 'A special event',
          isDone: false
      ),
    ],
  };

  void _handleData(date){
    setState(() {
      selectedDay = date;
      selectedEvent = _events[selectedDay] ?? [];
    });
    Logger().d(selectedDay);
  }

  @override
  void initState() {
    selectedEvent = _events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("벗",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () {
            Provider.of<PageNotifier>(context, listen: false)
                .goToOtherPage(AuthPage.pageName);
          })
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Calendar(
            startOnMonday: false,
            locale: 'ko_KR',
            selectedColor: Palette.newBlue,
            todayColor: Palette.newBlue,
            eventColor: Colors.green,
            eventDoneColor: Colors.amber,
            bottomBarColor: Palette.newBlue,
            hideTodayIcon: true,
            onRangeSelected: (range){
              Logger().d('Selected Day ${range.from}, ${range.to}');
            },
            onDateSelected: (date){
              return _handleData(date);
            },
            events: _events,
            isExpanded: true,
            dayOfWeekStyle: TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
            bottomBarTextStyle: TextStyle(
              color: Colors.white,
            ),
            hideBottomBar: false,
            isExpandable: false,
            hideArrows: false,
            weekDays: ['일','월','화','수','목','금','토'],
          ),
        ),
      ),
    );
  }
}
