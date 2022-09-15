import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/api/calendar/setCalendar.dart';
import 'package:front_nearby_caregiver/pages/calendar/calendar_page.dart';
import 'package:front_nearby_caregiver/provider/page_notifier.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../thema/palette.dart';

class AddCalendarPage extends Page{
  static final pageName = 'AddCalendarPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings:this, builder: (context)=>AddCalendarWidget());
  }
}

class AddCalendarWidget extends StatefulWidget {
  const AddCalendarWidget({Key? key}) : super(key: key);

  @override
  State<AddCalendarWidget> createState() => _AddCalendarWidgetState();
}

class _AddCalendarWidgetState extends State<AddCalendarWidget> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _calendarName = TextEditingController();
  late String _selectedStartTime = '${TimeOfDay.now().hour}:00';
  late String _selectedEndTime = '${TimeOfDay.now().hour+1}:00';
  var _setDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<PageNotifier>().selectedDate,
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading:  IconButton(
            onPressed: () {
              Provider.of<PageNotifier>(context, listen: false)
                  .goToOtherPage(CalendarPage.pageName);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 16, left: 32, right: 32),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _calendarName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                  ),
                  validator: (text){
                    if((text == null || text.isEmpty))
                    {
                      return "입력창이 비어있어요!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "일정 제목",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.5)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.5)),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                    errorStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                    ),
                  )
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("시작시간",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("$_selectedStartTime",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    OutlinedButton(
                        onPressed: (){
                          Future<TimeOfDay?> selected = showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now()
                          );
                          selected.then((time) => {
                            setState((){
                              _selectedStartTime = '${time?.hour}:${time?.minute}';
                              _selectedEndTime = '${time?.hour}:${time?.minute}';
                              var day = DateTime.parse(context.read<PageNotifier>().selectedDate);
                              int? hour = time?.hour;
                              int? minute = time?.minute;
                              _setDate = DateTime(day.year, day.month, day.day, hour!, minute!);
                            })
                          });
                        },
                        child: Text('시간설정',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Palette.newBlue,
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    if(_formkey.currentState!.validate())
                    {
                      // permission();
                      setCalendar(
                          context.read<PageNotifier>().selectedElderly.elderlyId,
                          _setDate,
                          _calendarName.text);
                      Provider.of<PageNotifier>(context, listen: false)
                          .goToOtherPage(CalendarPage.pageName);
                    }
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Palette.newBlue,
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    padding: EdgeInsets.all(16),// foreground
                  ),
                  child: Text(
                    "저장하기"
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
