import 'package:chat_socket/foundation/msg_widget/other_msg_widget.dart';
import 'package:chat_socket/socket_io_chat/chat_message_model.dart';
import 'package:chat_socket/socket_io_chat/chat_title.dart';
import 'package:chat_socket/socket_io_chat/login_screen.dart';
import 'package:chat_socket/socket_io_chat/msg_model.dart';
import 'package:chat_socket/socket_io_chat/user.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../foundation/msg_widget/own_msg_widget.dart';
import 'global.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String routeId = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  List<ChatMessageModel> _chatMessages = [];
  late User _toChatUser;
  late UserOnlineStatus _userOnlineStatus;
  IO.Socket? socket;
  TextEditingController _messageController = TextEditingController();
  List<MsgModel> _msgList = [];
  late String userId;

  @override
  void initState() {
    super.initState();
    _toChatUser = G.toChatUser!;
    _userOnlineStatus = UserOnlineStatus.connecting;
    _connect();
    userId = G.userId!;
  }

  _connect() {
    print('2222');
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('connect');
    });
    socket!.on('sendMsgServer', (data) {
      MsgModel _msgServer = MsgModel.fromJson(data);
      if (_msgServer.userId != userId) {
        _msgList.add(_msgServer);
        _setState();
      }
    });
    // socket!.onDisconnect((_) => print('disconnect'));
    // socket!.on('fromServer', (_) => print(_));
  }

  _sendMsg(String msg, String senderName) {
    MsgModel _ownMsg = MsgModel(
      type: "ownMsg",
      msg: msg,
      senderName: senderName,
      userId: userId,
    );
    _msgList.add(_ownMsg);
    _setState();
    socket!.emit('sendMsg', {
      "type": "ownMsg",
      "msg": msg,
      "senderName": senderName,
      "userId": userId,
    });
  }

  _setState() {
    return setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChatTitle(
          toChatUser: _toChatUser,
          userOnlineStatus: _userOnlineStatus,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            // OwnMsgWidget(sender: G.loggedInUser!.name!, msg: 'dsd'),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _chatMessages.length,
            //     itemBuilder: (context, index) {
            //       ChatMessageModel chatMessageModel = _chatMessages[index];
            //       return Text(chatMessageModel.message);
            //     },
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: _msgList.length,
                itemBuilder: (context, index) {
                  if (_msgList[index].type == 'ownMsg') {
                    return OwnMsgWidget(
                        sender: G.loggedInUser!.name!,
                        msg: _msgList[index].msg);
                  } else {
                    return OtherMsgWidget(
                        sender: _toChatUser.name!, msg: _msgList[index].msg);
                  }
                },
              ),
            ),
            _bottomChatArea(),
          ],
        ),
      ),
    );
  }

  _bottomChatArea() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          _chatTextArea(),
          IconButton(
            onPressed: () {
              String msg = _messageController.text;
              if (msg.isNotEmpty) {
                _sendMsg(msg, _toChatUser.name!);
                _messageController.clear();
              }
              _setState();
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }

  _chatTextArea() {
    return Expanded(
      child: TextField(
        controller: _messageController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(10.0),
          hintText: "Type Message",
        ),
      ),
    );
  }
}
