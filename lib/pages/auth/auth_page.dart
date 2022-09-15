import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/api/auth/register.dart';
import 'package:front_nearby_caregiver/api/init.dart';
import 'package:front_nearby_caregiver/pages/auth/permission_record_page.dart';
import 'package:front_nearby_caregiver/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../api/auth/login.dart';
import '../../data/user.dart';
import '../../provider/page_notifier.dart';

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
  TextEditingController _caregiverPhoneNumberController = TextEditingController();

  bool isRegister = false;
  Duration _duration = Duration(milliseconds: 300);
  Curve _curve = Curves.fastOutSlowIn;

  static final double _cornerRadius = 3.0;

  String userInfo = "";
  static final storage = new FlutterSecureStorage();

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    userInfo = (await storage.read(key: "login"))!;

    if(userInfo != null)
      {
        loginUser(userInfo.split(" ")[1], userInfo.split(" ")[3]);
        Provider.of<PageNotifier>(context, listen: false)
            .goToOtherPage(HomePage.pageName);
        Provider.of<PageNotifier>(context, listen: false)
            .setList(getElderlyList() as List<UserOA>);
      }
  }

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
                    SizedBox(height: 50),
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
                        height: isRegister ? 150 : 0,
                        child: Column(
                          children: [
                            _buildTextFormField(
                                "이름", _caregiverNameController),
                            SizedBox(height: 8),
                            _buildTextFormField(
                                "전화번호", _caregiverPhoneNumberController)
                          ],
                        )),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        if(_formkey.currentState!.validate())
                        {
                          if(isRegister)
                            {
                              registerUser(
                                  _caregiverEmailController.text,
                                  _caregiverPasswordController.text,
                                  _caregiverNameController.text,
                                  _caregiverPhoneNumberController.text
                              );
                              storage.write(
                                  key: "login",
                                  value: "email ${_caregiverEmailController.text} password ${_caregiverPasswordController.text}"
                              );
                              Provider.of<PageNotifier>(context, listen: false)
                                  .goToOtherPage(PermissionRecordPage.pageName);
                            }
                          else
                            {
                              loginUser(_caregiverEmailController.text, _caregiverPasswordController.text);
                              if(getUserID() == "200")
                                {
                                  storage.write(
                                    key: "login",
                                    value: "email ${_caregiverEmailController.text} password ${_caregiverPasswordController.text}"
                                  );

                                  Provider.of<PageNotifier>(context, listen: false)
                                      .goToOtherPage(HomePage.pageName);
                                  Provider.of<PageNotifier>(context, listen: false)
                                      .setList(getElderlyList() as List<UserOA>);
                                }
                            }
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
                    SizedBox(height: 30),
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
          if((text == null || text.isEmpty) && isRegister)
          {
            return "입력창이 비어있어요!";
          }
          else if(text == null || text.isEmpty
              && (controller != _caregiverNameController)
              && (controller != _caregiverPhoneNumberController))
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
