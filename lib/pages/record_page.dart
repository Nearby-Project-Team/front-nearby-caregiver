import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordPage extends Page{
  static final String pageName = 'Recordpage';

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
  String viewTxt = "Recorde Player";

  FlutterSoundRecorder? myRecorder;
  FlutterSoundPlayer? myPlayer;
  bool check = false;
  bool playCheck = false;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.microtask(() async{
      myRecorder = (await FlutterSoundRecorder().openAudioSession())!;
      myPlayer = (await FlutterSoundPlayer().openAudioSession())!;
    });
    super.initState();
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
      appBar: AppBar(
        title: Text("녹음!!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              viewTxt,
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: _recodeFunc,
                tooltip: 'Increment',
                child: check ? Icon(Icons.stop) :Icon(Icons.play_arrow),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child: Column(
                children: <Widget>[
                  Text("Play Controller\n(Recorde File)"),
                  IconButton(
                    icon: playCheck ? Icon(Icons.stop) : Icon(Icons.play_circle_filled),
                    onPressed: () async{
                      await playMyFile();
                    },
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Future<void> _recodeFunc() async{
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) throw RecordingPermissionException("Microphone permission not granted");
    setState(() {
      viewTxt = "Recoding ~";
    });
    if(!check){
      Directory tempDir = await getTemporaryDirectory();
      File outputFile = File('${tempDir.path}/flutter_sound-tmp.mp4');
      await myRecorder?.startRecorder(toFile: outputFile.path,codec: Codec.aacMP4);
      print("START");
      setState(() {
        check = !check;
      });
      return;
    }
    print("STOP");
    setState(() {
      check = !check;
      viewTxt = "await...";
    });
    await myRecorder?.stopRecorder()
        .then((value) => {
          setState((){
            viewTxt = "Check";
          })
    });
    return;
  }

  Future<void> playMyFile() async{
    if(!playCheck){
      Directory tempDir = await getTemporaryDirectory();
      File inFile = File('${tempDir.path}/flutter_sound-tmp.mp4');
      try{
        Uint8List dataBuffer = await inFile.readAsBytes();
        print("dataBuffer $dataBuffer");
        setState(() {
          playCheck = !playCheck;
        });
        await this.myPlayer?.startPlayer(
            fromDataBuffer: dataBuffer,
            codec: Codec.aacMP4,
            whenFinished: () {
              print('Play finished');
              setState(() {});
            });
      }
      catch(e){
        print(" NO Data");
        _key.currentState?.showSnackBar(
            SnackBar(
              content: Text("NO DATA!!!!!!"),
            )
        );
      }
      return;
    }
    await myPlayer?.stopPlayer();
    setState(() {
      playCheck = !playCheck;
    });
    print("PLAY STOP!!");
    return;
  }

}
