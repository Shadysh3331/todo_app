class UserModel{
  String id;
  String username;
  String phone;
  int age;
  String email;

  UserModel({
    this.id = "",
    required this.username,
    required this.phone,
    required this.age,
    required this.email
  });

  UserModel.fromJson(Map <String,dynamic> json):
  this(
        id: json['id'],
        username: json['username'],
        phone: json['phone'],
        age: json['age'],
        email: json['email'],
  );

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'username':username,
      'phone':phone,
      'age':age,
      'email':email,
    };
  }
}