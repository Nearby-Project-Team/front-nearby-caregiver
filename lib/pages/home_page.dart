import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_nearby_caregiver/pages/auth/auth_page.dart';
import 'package:front_nearby_caregiver/pages/auth/register_oa_page.dart';
import 'package:front_nearby_caregiver/pages/calendar/calendar_page.dart';
import 'package:front_nearby_caregiver/provider/page_notifier.dart';
import 'package:provider/provider.dart';
import 'package:front_nearby_caregiver/data/user.dart';

import '../api/init.dart';
import '../thema/palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final String pageName = 'Homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final storage = FlutterSecureStorage();
  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });

  }

  _asyncMethod() async {
    Provider.of<PageNotifier>(context, listen: false)
        .setList(getElderlyList() as List<UserOA>);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("어르신 선택하기",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () {
            storage.delete(key: "login");
            Provider.of<PageNotifier>(context, listen: false)
                .goToOtherPage(AuthPage.pageName);
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              for(int i = 0; i < context.watch<PageNotifier>().elderlyList.length; i++)...
              [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),// NEW
                    ),
                    onPressed: (){
                      Provider.of<PageNotifier>(context, listen: false)
                          .goToOtherPage(CalendarPage.pageName);
                      Provider.of<PageNotifier>(context, listen: false)
                          .setElderly(context.read<PageNotifier>().elderlyList[i]);
                    },
                    child: Text(
                      context.watch<PageNotifier>().elderlyList[i].elderlyName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Palette.newBlue,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),// NEW
                ),
                onPressed: (){
                  Provider.of<PageNotifier>(context, listen: false)
                      .goToOtherPage(RegisterOAPage.pageName);
                },
                child: Text(
                  "어르신 등록하기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
