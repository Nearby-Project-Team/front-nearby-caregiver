import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/pages/calendar_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';

import '../provider/page_notifier.dart';

class AuthPage extends Page{

  static final pageName = 'AuthPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings:this, builder: (context)=>AuthWidget());
  }

}

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _caregiverEmailController = TextEditingController();
  TextEditingController _caregiverPasswordController = TextEditingController();
  TextEditingController _caregiverNameController = TextEditingController();

  bool isRegister = false;
  Duration _duration = Duration(milliseconds: 300);
  Curve _curve = Curves.fastOutSlowIn;

  static final double _cornerRadius = 3.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Palette.newBlue,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Form(
                key: _formkey,
                child: ListView(
                  reverse: true,
                  padding: EdgeInsets.all(16),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
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
                        SizedBox(width: 10),
                        Text(
                          "벗",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("친근한 목소리를 가진",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,)),
                        Text("노인 맞춤 인공지능 비서",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,)),
                      ],
                    ),
                    SizedBox(height: 100),
                    ButtonBar(
                      children: [
                        TextButton(
                          onPressed: (){
                            setState((){
                              isRegister = false;
                            });
                          },
                          child: Text("Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: isRegister
                                ? FontWeight.w400
                                : FontWeight.w600,
                            color: isRegister
                                ? Colors.white54
                                : Colors.white, ),
                        ),),
                        TextButton(
                          onPressed: (){
                            setState((){
                              isRegister = true;
                            });
                          },
                          child: Text("Register",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: isRegister
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isRegister
                                  ? Colors.white
                                  : Colors.white54, ),
                          ),),
                      ]
                    ),
                    SizedBox(height: 8),
                    _buildTextFormField("이메일", _caregiverEmailController),
                    SizedBox(height: 8),
                    _buildTextFormField("비밀번호", _caregiverPasswordController),
                    SizedBox(height: 8),
                    AnimatedContainer(
                        duration: _duration,
                        curve: _curve,
                        height: isRegister ? 60 : 0,
                        child: _buildTextFormField(
                            "이름", _caregiverNameController)),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // TODO: 로그인 분기 나눠야 함.
                        if(_formkey.currentState!.validate())
                        {
                          // permission();
                          Provider.of<PageNotifier>(context, listen: false)
                              .goToOtherPage(CalendarPage.pageName);
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: Palette.newBlue,
                        backgroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_cornerRadius)),
                        padding: EdgeInsets.all(16),// foreground
                      ),
                      child: Text(
                        isRegister ? "회원가입" : "로그인",
                      ),),
                    SizedBox(height: 50),
                  ].reversed.toList(),
                ),
              ),
            ),
          )
      ),
    );
  }

  TextFormField _buildTextFormField(String labelText, TextEditingController controller) {
    return TextFormField(
        controller: controller,
        validator: (text){
          if(text == null || text.isEmpty)
          {
            return "입력창이 비어있어요!";
          }
          return null;
        },
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400
        ),
        decoration: InputDecoration(
          fillColor: Colors.black54,
          filled: true,
          labelText: labelText,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(_cornerRadius)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(_cornerRadius)),
          labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400
          ),
          errorStyle: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w600
          ),
        )
    );
  }
}


// Future<bool> permission() async {
//   Map<Permission, PermissionStatus> status =
//   await [Permission.speech].request(); // [] 권한배열에 권한을 작성
//
//   if (await Permission.speech.isGranted) {
//     return Future.value(true);
//   } else {
//     return Future.value(false);
//   }
// }
