class MsgModel {
  String type;
  String msg;
  String senderName;
  String userId;

  MsgModel({
    required this.type,
    required this.msg,
    required this.senderName,
    required this.userId,
  });

  factory MsgModel.fromJson(Map<String, dynamic> json) {
    return MsgModel(
      type: json["type"] as String,
      msg: json["msg"] as String,
      senderName: json["senderName"] as String,
      userId: json["userId"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "msg": msg,
        "senderName": senderName,
        "userId": userId,
      };
}
