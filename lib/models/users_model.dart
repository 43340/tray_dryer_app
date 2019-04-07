class Users {
  String name;
  bool admin;
  String publicId;

  Users({this.name, this.admin, this.publicId});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json["name"],
      admin: json["admin"],
      publicId: json["public_id"],
    );
  }
}
