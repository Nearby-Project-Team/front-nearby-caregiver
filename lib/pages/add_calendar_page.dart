import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/provider/page_notifier.dart';
import 'package:provider/provider.dart';

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
  late String _selectedStartTime = '${TimeOfDay.now().hour}:00';
  late String _selectedEndTime = '${TimeOfDay.now().hour+1}:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<PageNotifier>().selectedDate,
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text("시작시간"),
                  Text("$_selectedStartTime"),
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
                          })
                        });
                      },
                      child: Text('시간설정'))
                ],
              ),
              Row(
                children: [
                  Text("마침시간"),
                  Text("$_selectedEndTime"),
                  OutlinedButton(
                      onPressed: (){
                        Future<TimeOfDay?> selected = showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()
                        );
                        selected.then((time) => {
                          setState((){
                            _selectedEndTime = '${time?.hour}:${time?.minute}';
                          })
                        });
                      },
                      child: Text('시간설정'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
