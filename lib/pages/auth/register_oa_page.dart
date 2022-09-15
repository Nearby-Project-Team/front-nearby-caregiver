import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_nearby_caregiver/api/auth/login.dart';
import 'package:front_nearby_caregiver/api/elderly/getOAList.dart';
import 'package:front_nearby_caregiver/api/init.dart';
import 'package:front_nearby_caregiver/pages/home_page.dart';
import 'package:provider/provider.dart';
import '../../api/elderly/registerOA.dart';
import '../../data/user.dart';
import '../../provider/page_notifier.dart';
import '../../thema/palette.dart';

class RegisterOAPage extends Page{
  static final String pageName = 'RegisterOAPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings:this, builder: (context)=>RegisterOAWidget());
  }
}

class RegisterOAWidget extends StatefulWidget {
  const RegisterOAWidget({Key? key}) : super(key: key);

  @override
  State<RegisterOAWidget> createState() => _RegisterOAWidgetState();
}

class _RegisterOAWidgetState extends State<RegisterOAWidget> {
  GlobalKey<FormState> _formkeyOA = GlobalKey<FormState>();
  TextEditingController _oaNameController = TextEditingController();
  TextEditingController _oaBirthDayController = TextEditingController();
  TextEditingController _oaPhoneNumberController = TextEditingController();

  String userInfo = "";
  static final storage = new FlutterSecureStorage();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("어르신 등록하기",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Palette.newBlue,
          child: Scaffold(
            body: SafeArea(
              child: Form(
                key: _formkeyOA,
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    SizedBox(height: 8),
                    _buildTextFormField(
                        "어르신 이름",
                        _oaNameController
                    ),
                    SizedBox(height: 8),
                    _buildTextFormField(
                        "어르신 생년월일 (예: 1900-01-01)",
                        _oaBirthDayController
                    ),
                    SizedBox(height: 8),
                    _buildTextFormField(
                        "어르신 전화번호 (예: 01012345678)",
                        _oaPhoneNumberController
                    ),
                    const SizedBox(height: 20),
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
                        if(_formkeyOA.currentState!.validate())
                          {
                            registerOA(getUserEmail(),
                                _oaNameController.text,
                                _oaBirthDayController.text,
                                _oaPhoneNumberController.text);
                            Provider.of<PageNotifier>(context, listen: false)
                                .goToOtherPage(HomePage.pageName);
                            Provider.of<PageNotifier>(context, listen: false)
                                .setList(getElderlyList() as List<UserOA>);
                          }
                      },
                      child: Text("등록하기"),
                    )
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(String labelText, TextEditingController controller) {
    return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.always,
        validator: (text){
          if(text == null || text.isEmpty)
          {
            return "입력창이 비어있어요!";
          }
          return null;
        },
        onSaved: (val){},
        style: TextStyle(
            fontWeight: FontWeight.w400
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400
          ),
          errorStyle: TextStyle(
              fontWeight: FontWeight.w600
          ),
        )
    );
  }

}
