import 'package:chat_socket/socket_io_chat/chat_user_screen.dart';
import 'package:chat_socket/socket_io_chat/login_screen.dart';

import 'chat_screen.dart';

class Routes {
  static routes() {
    return {
      LoginScreen.routeId: (context) => const LoginScreen(),
      ChatUserScreen.routeId: (context) => const ChatUserScreen(),
      ChatScreen.routeId: (context) => const ChatScreen(),
    };
  }

  static initScreen() {
    return LoginScreen.routeId;
  }
}
