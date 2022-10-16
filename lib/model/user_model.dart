class UserModel
{
  String? name;
  String? phone;
  String? uid;
  String? email;
  String? img;
  String? bio;

  UserModel({
    required this.uid,
    required this.phone,
    required this.email,
    required this.name,
    required this.img,
    required this.bio,
});

  UserModel.fromJson(Map<String , dynamic> json)
  {
    email = json["email"];
    name = json["name"];
    img = json["img"];
    uid = json["uid"];
    phone = json["phone"];
    bio = json["bio"];
  }

  Map<String , dynamic> toMap()
  {
    return {
      "name":name,
      "email":email,
      "uid":uid,
      "phone" : phone,
      "img" : img,
      "bio" : bio,
    };
  }
}