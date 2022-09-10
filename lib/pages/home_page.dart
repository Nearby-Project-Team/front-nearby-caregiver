import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/pages/auth/auth_page.dart';
import 'package:front_nearby_caregiver/pages/auth/register_oa_page.dart';
import 'package:front_nearby_caregiver/pages/calendar/calendar_page.dart';
import 'package:front_nearby_caregiver/provider/page_notifier.dart';
import 'package:provider/provider.dart';

import '../thema/palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final String pageName = 'Homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _test = ["AAA", "BBB", "CCC"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("어르신 선택하기",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () {
            Provider.of<PageNotifier>(context, listen: false)
                .goToOtherPage(AuthPage.pageName);
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for(int i = 0; i < _test.length; i++)...
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
                  },
                  child: Text(
                    _test[i],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Palette.newBlue,
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
    );
  }
}
