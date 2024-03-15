// make class to handle data from map
class SocilUserModel {
  String? name;
  String? phone;
  String? email;
  String? uID;
  String? Image;
  String? Cover;
  String? bio;

// make constarctor from class
  SocilUserModel({
    this.email,
    this.name,
    this.phone,
    this.uID,
    this.Image,
    this.Cover,
    this.bio,
  });

  // make named constractor to get data from map and store it in variables
  SocilUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uID = json['uID'];
    Image = json['Image'];
    Cover = json['Cover'];
    bio = json['bio'];
  }

  // to convert data to map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uID': uID,
      'Image': Image,
      'Cover': Cover,
      'bio': bio,
    };
  }
}
