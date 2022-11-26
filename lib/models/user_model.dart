class UserModel {
  String id;

  String name;

  String email;

  String image;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['uId'],
        name: json['name'],
        email: json['email'],
        image: json['urlImage']);
  }

  Map<String , dynamic> toJson(){
    return {
      'uId' : id  ,
      'name' : name ,
      'email' : email ,
      'urlImage' : image
    };
  }
}
