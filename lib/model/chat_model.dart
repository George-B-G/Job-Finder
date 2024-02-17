class ChatModel {
  String? senderId;
  String? senderEmail;
  String? message;
  String? recieverId;
  String? recieverEmail;
  String? receiverName;
  String? timeStamp;

  ChatModel({
    required this.message,
    required this.senderEmail,
    required this.senderId,
    required this.recieverEmail,
    required this.recieverId,
    required this.timeStamp,
    required this.receiverName,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    senderEmail = json['senderEmail'];
    senderId = json['senderId'];
    recieverEmail = json['recieverEmail'];
    recieverId = json['recieverId'];
    timeStamp = json['timeStamp'];
    receiverName = json['receiverName'];
  }

  Map<String, dynamic> toMap() => {
        'senderID': senderId,
        'senderEmail': senderEmail,
        'message': message,
        'timeStamp': timeStamp,
        'recieverId': recieverId,
        'recieverEmail': recieverEmail,
        'receiverName': receiverName,
      };
}
