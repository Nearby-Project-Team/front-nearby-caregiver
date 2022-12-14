import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/pages/auth/record_page.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';
import 'package:provider/provider.dart';

import '../../provider/page_notifier.dart';

class PermissionRecordPage extends Page {
  static final String pageName = 'PermissionRecordPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings:this, builder: (context)=>PermissionRecordWidget());
  }
}

class PermissionRecordWidget extends StatefulWidget {
  const PermissionRecordWidget({Key? key}) : super(key: key);

  @override
  State<PermissionRecordWidget> createState() => _PermissionRecordWidgetState();
}

class _PermissionRecordWidgetState extends State<PermissionRecordWidget> {
  bool _setPermission = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.black26,
                          spreadRadius: 3)
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: Image.asset('assets/logo-noback.png'),
                  ),
                ),
                SizedBox(height: 70),
                _setPermission
                    ? _goToRecordPage()
                    : _setPermissionRecord(),
                SizedBox(height: 200),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Palette.newBlue,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    padding: EdgeInsets.all(16),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),// NEW
                  ),
                  onPressed: (){
                    _setPermission ? {
                      Provider.of<PageNotifier>(context, listen: false)
                          .goToOtherPage(RecordPage.pageName)
                    }:{
                      setState((){
                        _setPermission = true;
                      })
                    };
                  },
                  child: _setPermission ? Text("??????") : Text("?????? ??? ?????? ?????? ????????????"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _goToRecordPage extends StatelessWidget {
  const _goToRecordPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
    Text("???????????? ??????????????? ????????????",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Palette.newBlue)),
    Text("?????????????????????.",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Palette.newBlue)),
    Text("  ",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,)),
    Text("??? 7????????? ????????? ???????????????.",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,)),
                  ],
                );
  }
}

class _setPermissionRecord extends StatelessWidget {
  const _setPermissionRecord({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("???????????? ??????????????? ????????????",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,)),
        Text("???????????? ?????? ????????? ???????????????.",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("????????? ????????? ????????? ????????? ??????",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Palette.newBlue)),
            Text("?????????",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,)),
          ],
        ),
        Text("?????? ????????? ???????????????.",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,)),
      ],
    );
  }
}
