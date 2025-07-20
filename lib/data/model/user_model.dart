class UserModel {
  final String id;
  final String email;
  final String userName;
  final String password;


  UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.password,

  });

  Map<String, dynamic> tojson(){
    return{
      'id':id,
      'email':email,
      'userName':userName,
      'password':password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic>json)=> UserModel(
    id:json['id'],
     email:json[' email'],
      userName: json['userName'],
       password: json['password']
       );
}