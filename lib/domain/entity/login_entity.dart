import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LoginEntity extends Equatable {
  final String name;
  final String email;
  final String photoUrl;

  LoginEntity({
    @required this.name,
    @required this.email,
    @required this.photoUrl,
  });

  @override
  List<Object> get props => [name, email, photoUrl];
}
