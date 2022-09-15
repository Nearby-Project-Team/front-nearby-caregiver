import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class CalendarUser{
  late final String elderlyId;
  late final Map<DateTime, List<CleanCalendarEvent>>? oneOff;
  late final List<Event>? repeat;

  CalendarUser({
    required this.elderlyId,
    required this.repeat,
    required this.oneOff,
  });

  Map<DateTime, List<CleanCalendarEvent>>? getOneOffList() {
    return oneOff;
  }

  factory CalendarUser.fromJson(Map<String, dynamic> calendarMap, String elderlyId)
  {
    List<Event> repeatList = [];
    Map<DateTime, List<CleanCalendarEvent>> oneOffList = {};

    var list = calendarMap['data'] as List;
    List<Event> calendarList = list.map((i) => Event.fromJson(i)).toList();

    for(int i = 0; i < calendarList.length; i++)
      {
        if(calendarList[i].notificationType == "ONEOFF")
          {
            var date = DateTime.parse(calendarList[i].scheduleDate);
            date = DateTime(date.year, date.month, date.day, date.hour, date.minute);
            oneOffList[DateTime(date.year, date.month, date.day)] = [
              CleanCalendarEvent(calendarList[i].content,
                startTime: date,
                endTime: DateTime(date.year, date.month, date.day, date.hour+1, date.minute),
                description: ' ',
                isDone: false
              ),
            ];
          }
        else
          {
            repeatList.add(calendarList[i]);
          }
      }
    return CalendarUser(
        elderlyId: elderlyId,
        repeat: repeatList,
        oneOff: oneOffList
    );
  }
}

class Event{
  late final String content;
  late final String scheduleDate;
  late final String createdAt;
  late final String notificationType;

  Event({
    required this.content,
    required this.scheduleDate,
    required this.createdAt,
    required this.notificationType,
  });

  factory Event.fromJson(Map<String, dynamic> eventMap)
  {
    return Event(
        content: eventMap['content'],
        scheduleDate: eventMap['scheduleDate'],
        createdAt: eventMap['createdAt'],
        notificationType: eventMap['notificationType'],
    );
  }
}
