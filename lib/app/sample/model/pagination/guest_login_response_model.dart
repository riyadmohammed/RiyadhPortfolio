import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';

class GuestLoginResponseModel {
  String? id;
  String? userName;
  String? email;
  List<String>? roles;
  String? accessToken;
  String? refreshToken;

  GuestLoginResponseModel({this.id, this.userName, this.email, this.roles, this.accessToken, this.refreshToken});
  GuestLoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = DynamicParsing(json['id']).parseString();
    userName = DynamicParsing(json['userName']).parseString();
    email = DynamicParsing(json['email']).parseString();
    roles = List<String>.from(json['roles'] ?? []);
    accessToken = DynamicParsing(json['accessToken']).parseString();
    refreshToken = DynamicParsing(json['refreshToken']).parseString();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'email': email,
      'roles': roles,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
