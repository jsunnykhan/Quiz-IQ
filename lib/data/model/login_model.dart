import '../../domain/entity/login_entity.dart';
import 'package:meta/meta.dart';

class LoginModel extends LoginEntity {
  final String name;
  final String email;
  final String photoUrl;

  LoginModel({
    @required this.name,
    @required this.email,
    @required this.photoUrl,
  }) : super(
          email: email,
          name: name,
          photoUrl: photoUrl,
        );
  factory LoginModel.formJson(Map<String, dynamic> json) {
    return LoginModel(
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
    };
  }
}
