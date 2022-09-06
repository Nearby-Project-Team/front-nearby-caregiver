import 'package:flutter/material.dart';
import 'package:front_nearby_caregiver/component/chat_message.dart';
import 'package:front_nearby_caregiver/thema/palette.dart';

class ChattingPage extends Page{
  static final String pageName = 'ChattingPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings:this, builder: (context)=>ChattingWidget());
  }
}

class ChattingWidget extends StatefulWidget {
  const ChattingWidget({Key? key}) : super(key: key);

  @override
  State<ChattingWidget> createState() => _ChattingWidgetState();
}

class _ChattingWidgetState extends State<ChattingWidget> {
  GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();
  TextEditingController _textEditingController = TextEditingController();
  List<String> _chats = [];
  String _text = ' ';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("벗",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
              child: AnimatedList(
                key: _animListKey,
                reverse: true,
                itemBuilder: _buildItem,
              )),
          inputSendContainer(),
          const SizedBox(
            width: 0.8,
          ),
        ],
      ),
    );
  }

  Container inputSendContainer() {
    return Container( // 입력창 & 전송버튼
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        hintText: "메시지 입력창",
                        border: InputBorder.none,
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                const SizedBox(
                  width: 0.8,
                ),
                IconButton(onPressed: () {
                  _handleSubmitted(_textEditingController.text);
                },
                  icon: Icon(Icons.send),
                  color: Palette.newBlue,
                ),
              ]
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildItem(context, index, animation) {
    return ChatMessage(_chats[index], animation: animation);
  }

  void _handleSubmitted(String text) async {
    _textEditingController.clear();
    _chats.insert(0, text);
    _animListKey.currentState?.insertItem(0);
  }
}
