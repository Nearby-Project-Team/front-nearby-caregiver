import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBox extends StatefulWidget {
  const CalendarBox({Key? key}) : super(key: key);

  @override
  State<CalendarBox> createState() => _CalendarBoxState();
}

class _CalendarBoxState extends State<CalendarBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        locale: 'ko_KR',
        headerStyle: HeaderStyle(
          headerMargin: EdgeInsets.only(left: 40, top: 5, right: 40, bottom: 10),
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(Icons.arrow_left),
          rightChevronIcon: Icon(Icons.arrow_right),
          titleTextStyle: const TextStyle(fontSize: 17.0),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: true,
          weekendTextStyle: TextStyle().copyWith(color: Colors.red),
          holidayTextStyle: TextStyle().copyWith(color: Colors.blue[800]),
        ),
      ),
    );
  }
}
