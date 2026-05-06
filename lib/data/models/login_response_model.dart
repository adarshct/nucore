class LoginResponse {
  bool? success;
  String? message;
  LoginData? data;

  LoginResponse({this.success, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] == null ? null : LoginData.fromJson(json['data']),
    );
  }
}

class LoginData {
  String? token;
  String? role;
  User? user;

  LoginData({this.token, this.role, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      role: json['role'],
      user: json['user'] == null ? null : User.fromJson(json['user']),
    );
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? role;
  String? createdAt;

  User({this.id, this.name, this.email, this.role, this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      createdAt: json['createdAt'],
    );
  }
}
