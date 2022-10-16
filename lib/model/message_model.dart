class   MessageModel
{
  String? senderId;
  String? receiverId;
  String? message;
  String? dateTime;


  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,

  });

  MessageModel.fromJson(Map<String , dynamic> json)
  {
    senderId = json["senderId"];
    receiverId = json["receiverId"];
    message = json["message"];
    dateTime = json["dateTime"];

  }

  Map<String , dynamic> toMap()
  {
    return {
      "senderId":senderId,
      "receiverId":receiverId,
      "message":message,
      "dateTime" : dateTime,

    };
  }
}