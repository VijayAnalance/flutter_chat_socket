import 'package:chat_socket/socket_io_chat/user.dart';
import 'package:flutter/material.dart';

enum UserOnlineStatus {
  connecting,
  online,
  notOnline,
}

class ChatTitle extends StatelessWidget {
  final User toChatUser;
  const ChatTitle({
    Key? key,
    required this.toChatUser,
    required this.userOnlineStatus,
  }) : super(key: key);

  final UserOnlineStatus userOnlineStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(toChatUser.name!),
          Text(
            _getStatusText(),
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }

  _getStatusText() {
    if (userOnlineStatus == UserOnlineStatus.online) {
      return "online";
    }
    if (userOnlineStatus == UserOnlineStatus.notOnline) {
      return "notOnline";
    }
    return "connecting";
  }
}
