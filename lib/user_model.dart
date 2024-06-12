class UserModel {
  String? id;
  String? username;
  String? phone;
  String? email;

  UserModel({this.id, this.email, this.phone, this.username});

  UserModel.fromjson(Map<String,dynamic>json):this(
  id: json['id'],
    email: json['email'],
    phone: json['phone'],
    username: json['username'],
  );

  Map<String,dynamic>tojson(){
    return{
      "id": id,
      "email": email,
      "phone": phone,
      "username": username,
    };
  }
}
