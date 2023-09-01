class UserModel {
  final String status;
  List<Data> data;
  UserModel({this.status = "no-status", this.data = const []});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        data: List<Data>.from(json["data"].map((e) => Data.fromJson(e))),
      );
}

class Data {
  int id;
  final String username;
  final String email;

  Data({this.id = 0, this.username = "no-isername", this.email = "no-email"});
  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(id: json["id"], username: json["username"], email: json["email"]);
}
