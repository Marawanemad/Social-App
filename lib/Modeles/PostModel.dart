// make class to handle data from map
class PostModel {
  String? uID;
  String? name;
  String? image;
  String? postImage;
  String? dateTime;
  String? text;

// make constarctor from class
  PostModel({
    this.uID,
    this.name,
    this.image,
    this.postImage,
    this.dateTime,
    this.text,
  });

  // make named constractor to get data from map and store it in variables
  PostModel.fromJson(Map<String, dynamic> json) {
    uID = json['uID'];
    name = json['name'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  // to convert data to map
  Map<String, dynamic> toMap() {
    return {
      'uID': uID,
      'name': name,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
