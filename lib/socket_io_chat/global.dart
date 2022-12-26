import 'package:uuid/uuid.dart';

import 'user.dart';

class G {
  static List<User> dummyUsers = [];

  static User? loggedInUser;

  static User? toChatUser;

  static String? userId;

  static void initDummyUsers() {
    dummyUsers = [];
    User userA = User(id: 1000, name: 'A', email: "testa@gmail.com");
    User userB = User(id: 2000, name: 'B', email: "testb@gmail.com");
    dummyUsers.add(userA);
    dummyUsers.add(userB);
    print('111');
    print('dummyUsers - ${dummyUsers.length}');
  }

  static List<User> getUserFor(User user) {
    List<User> filteredUser = dummyUsers
        .where(
          (u) => (!u.name!.toLowerCase().contains(
                user.name!.toLowerCase(),
              )),
        )
        .toList();
    return filteredUser;
  }
}
