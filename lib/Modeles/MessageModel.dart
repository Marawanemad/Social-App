// make class to handle data from map
class MessageModel {
  String? SenderID;
  String? ReceiverID;
  String? date;
  String? Time;
  String? messageText;
  String? messageImage;

// make constarctor from class
  MessageModel({
    this.SenderID,
    this.ReceiverID,
    this.date,
    this.Time,
    this.messageText,
    this.messageImage,
  });

  // make named constractor to get data from map and store it in variables
  MessageModel.fromJson(Map<String, dynamic> json) {
    SenderID = json['SenderID'];
    ReceiverID = json['ReceiverID'];
    date = json['date'];
    Time = json['Time'];
    messageText = json['messageText'];
    messageImage = json['messageImage'];
  }

  // to convert data to map
  Map<String, dynamic> toMap() {
    return {
      'SenderID': SenderID,
      'ReceiverID': ReceiverID,
      'date': date,
      'Time': Time,
      'messageText': messageText,
      'messageImage': messageImage,
    };
  }
}
