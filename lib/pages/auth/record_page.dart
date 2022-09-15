import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:front_nearby_caregiver/data/script_caregiver.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../api/auth/uploadVoiceFile.dart';
import '../../provider/page_notifier.dart';
import '../home_page.dart';

class RecordPage extends Page{
  static final String pageName = 'RecordPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings:this, builder: (context)=>RecordWidget());
  }
}

class RecordWidget extends StatefulWidget {
  const RecordWidget({Key? key}) : super(key: key);

  @override
  State<RecordWidget> createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<RecordWidget> {
  int index = 0;
  String viewTxt = " ";
  String userInfo = "";
  static final storage = new FlutterSecureStorage();


  FlutterSoundRecorder? myRecorder;
  FlutterSoundPlayer? myPlayer;
  bool check = false;
  bool playCheck = false;
  bool finalCheck = false;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.microtask(() async{
      myRecorder = (await FlutterSoundRecorder().openAudioSession())!;
      myPlayer = (await FlutterSoundPlayer().openAudioSession())!;
    });

    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });

    super.initState();
  }

  _asyncMethod() async {
    userInfo = (await storage.read(key: "login"))!;
  }

  @override
  void dispose(){
    if (myRecorder != null)
    {
      myRecorder?.closeAudioSession();
      myPlayer?.closeAudioSession();

      myRecorder = null;
      myPlayer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                check ? '아래 문장을 따라 읽고, \n다 읽었으면 다시 한번 버튼을 누르세요.'
                    :(
                    playCheck
                        ? '다음 문장 녹음하기 버튼을 누르거나 \n 다시 아래 문장을 녹음하세요.'
                        : '아래 파란색 버튼을 눌러서 \n녹음을 시작하세요'
                      ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Palette.newBlue,),
              ),
              SizedBox(height: 30),
              Text(
                viewTxt,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: _recodeFunc,
                  backgroundColor: check? Colors.white : Palette.newBlue,
                  tooltip: 'Increment',
                  child: check ? Icon(Icons.stop, color: Palette.newBlue,)
                      : Icon(Icons.mic, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              playCheck ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: finalCheck? Palette.newBlue : Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)
                  ),
                  padding: EdgeInsets.all(16),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),// NEW
                ),
                onPressed: (){
                  finalCheck ?
                  {
                    Provider.of<PageNotifier>(context, listen: false)
                        .goToOtherPage(HomePage.pageName)
                  }:
                  {
                    setState(() {
                      if (index == scriptCaregiver.length) {
                        finalCheck = !finalCheck;
                      }
                      else {
                        sendMyFile();
                        index++;
                        viewTxt = scriptCaregiver[index];
                        playCheck = !playCheck;
                      }
                    })
                  };
                },
                child: finalCheck
                    ? Text("목소리 등록 완료하기",
                    style:  TextStyle(color: Colors.white,
                  )): Text("다음 문장 녹음하기",
                    style:  TextStyle(color: Palette.newBlue,
                  )),
              ) : Container(),
              // Container(
              //   padding: EdgeInsets.all(20.0),
              //   decoration: BoxDecoration(
              //       border: Border.all(width: 2.0, color: Colors.grey),
              //       borderRadius: BorderRadius.circular(15.0)
              //   ),
              //   child: Column(
              //     children: <Widget>[
              //       Text("Play Controller\n(Recorde File)"),
              //       IconButton(
              //         icon: playCheck ? Icon(Icons.stop) : Icon(Icons.play_circle_filled),
              //         onPressed: () async{
              //           await playMyFile();
              //         },
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _recodeFunc() async{
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) throw RecordingPermissionException("Microphone permission not granted");

    if (!check)
    {
      Directory tempDir = await getTemporaryDirectory();
      File outputFile = File('${tempDir.path}/flutter_sound-tmp-$index.pcm');
      await myRecorder?.startRecorder(
        codec: Codec.pcm16,
        toFile: outputFile.path,
        sampleRate: 16000,
        numChannels: 1,
      );

      setState(() {
        if(index == 0)
          {
            index++;
            viewTxt = scriptCaregiver[index];
            playCheck = !playCheck;
          }
        check = !check;
      });
      return;
    }


    setState(() {
      check = !check;
      playCheck = true;
      // viewTxt = "await...";
    });

    await myRecorder?.stopRecorder()
        .then((value) => {
          setState((){
            // viewTxt = "Check";
          })
    });

    return;
  }


  Future<void> sendMyFile() async{
    if(playCheck){
      Directory tempDir = await getTemporaryDirectory();
      File inFile = File('${tempDir.path}/flutter_sound-tmp-${index}.pcm');
      await uploadVoiceFile(
          inFile,
          '${index-1}.pcm',
          userInfo.split(" ")[1],
          userInfo.split(" ")[3]
      );
      return;
    }
    return;
  }
}
