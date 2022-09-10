import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:front_nearby_caregiver/pages/calendar/add_calendar_page.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../provider/page_notifier.dart';
import '../auth/auth_page.dart';
import '../chatting/chatting_page.dart';

class CalendarPage extends Page{
  static final String pageName = 'CalendarPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings:this, builder: (context)=>CalenderWidget());
  }
}

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  late DateTime selectedDay = DateTime.now();
  late List selectedEvent;
  static final double _cornerRadius = 5.0;
  var _selected ="";

  late List<Map<String, dynamic>> _tagWater = [
    {'state': '아침', 'isCheck': false},
    {'state': '점심', 'isCheck': false},
    {'state': '저녁', 'isCheck': false},
  ];
  late List<Map<String, dynamic>> _tagPill = [
    {'state': '아침', 'isCheck': false},
    {'state': '점심', 'isCheck': false},
    {'state': '저녁', 'isCheck': false},
  ];

  // calendar dataset
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
        title: Text("어르신이름",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () {
            Provider.of<PageNotifier>(context, listen: false)
                .goToOtherPage(AuthPage.pageName);
          })
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 캘린더
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
            Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    // TODO: 날짜 채팅 기록 보여주는 페이지로 전환
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Palette.newBlue,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_cornerRadius)
                        ),// NEW
                      ),
                      onPressed: () {
                        Provider.of<PageNotifier>(context, listen: false)
                            .goToOtherPage(ChattingPage.pageName);
                      },
                      child: const Text(
                        '대화내용확인',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_cornerRadius)
                        ),// NEW
                      ),
                      onPressed: () {
                        context.read<PageNotifier>().set(selectedDay);
                        Provider.of<PageNotifier>(context, listen: false)
                            .goToOtherPage(AddCalendarPage.pageName);
                      },
                      child: const Text(
                        '일정추가',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Palette.newBlue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    //TODO: 채팅페이지 전환
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_cornerRadius)
                        ),// NEW
                      ),
                      onPressed: () {
                        Provider.of<PageNotifier>(context, listen: false)
                            .goToOtherPage(ChattingPage.pageName);
                      },
                      child: const Text(
                        '대화하기',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Palette.newBlue,),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // TODO: 반복 알림
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          '반복알림추가',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Palette.newBlue,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Ink(
                              width: 70,
                              child: IconButton(
                                icon: Icon(Icons.water_drop),
                                onPressed: () {
                                  // TODO: water 업데이트
                                  _displayDialog(context, _tagWater);
                                },
                                splashRadius: 40,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(_cornerRadius),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0,3),
                                    )
                                  ]
                              ),
                            ),
                            const SizedBox(width: 16),
                            Ink(
                              width: 70,
                              child: IconButton(
                                icon: Icon(Icons.punch_clock_rounded),
                                onPressed: () {
                                  _displayDialog(context, _tagPill);
                                },
                                splashRadius: 40,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(_cornerRadius),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0,3),
                                    )
                                  ]
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  _displayDialog(BuildContext context, tag) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return SimpleDialog(
              title: Text("반복알림 설정하기",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 10,
              children:[
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for(int index = 0; index < tag.length; index++)...[
                      ChoiceChip(
                        label: Text(
                          tag[index]['state'],
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: tag[index]['isCheck'],
                        backgroundColor: Colors.black26,
                        selectedColor: Palette.newBlue,
                        onSelected: (value){
                          setState((){
                            tag[index]['isCheck'] = !tag[index]['isCheck'];
                            Logger().d(tag[index]['isCheck'].toString());
                          });
                        },
                        elevation: 0,
                      )
                    ],
                  ],
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, "Burger");
                  },
                  child: const Text(
                    '설정하기',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Palette.newBlue,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
