import 'package:chat_socket/socket_io_chat/chat_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'global.dart';
import 'user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeId = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _usernameController;
  Uuid uuid = Uuid();
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    G.initDummyUsers();
    var userId = uuid.v1();
    G.userId = userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's chat"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _usernameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(20.0),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
              onPressed: () {
                _loginBtnTap();
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  _loginBtnTap() {
    if (_usernameController!.text.isEmpty) {
      return;
    }

    User me = G.dummyUsers[0];
    if (_usernameController!.text.toLowerCase() != 'a') {
      me = G.dummyUsers[1];
    }
    G.loggedInUser = me;
    _openChatUserListScreen(context);
  }

  _openChatUserListScreen(context) {
    Navigator.pushReplacementNamed(context, ChatUserScreen.routeId);
  }
}
