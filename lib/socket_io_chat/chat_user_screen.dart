import 'package:chat_socket/socket_io_chat/chat_screen.dart';
import 'package:chat_socket/socket_io_chat/login_screen.dart';
import 'package:chat_socket/socket_io_chat/user.dart';
import 'package:flutter/material.dart';

import 'global.dart';

class ChatUserScreen extends StatefulWidget {
  const ChatUserScreen({Key? key}) : super(key: key);
  static const String routeId = 'chat_user_screen';

  @override
  State<ChatUserScreen> createState() => _ChatUserScreen();
}

class _ChatUserScreen extends State<ChatUserScreen> {
  List<User>? _chatUsers;
  @override
  void initState() {
    super.initState();
    _chatUsers = G.getUserFor(G.loggedInUser!);
  }

  _openChatScreen(context) {
    Navigator.pushNamed(context, ChatScreen.routeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat User Screen"),
        actions: [
          ElevatedButton(
              onPressed: () {
                _openLoginScreen(context);
              },
              child: const Text('Logout'))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _chatUsers!.length,
                itemBuilder: (context, index) {
                  User user = _chatUsers![index];
                  return ListTile(
                    onTap: () {
                      G.toChatUser = user;
                      _openChatScreen(context);
                    },
                    title: Text(user.name!),
                    subtitle: Text('ID ${user.id}, Email: ${user.email}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openLoginScreen(context) {
    Navigator.pushReplacementNamed(context, LoginScreen.routeId);
  }
}
