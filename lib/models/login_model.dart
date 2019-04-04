class LoginModel {
  final String user;
  final String token;
  final bool admin;

  LoginModel(this.user, this.token, this.admin);

  LoginModel.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        token = json['token'],
        admin = json['admin'];

  Map<String, dynamic> toJson() => {
        'user': user,
        'token': token,
        'admin': admin,
      };
}
