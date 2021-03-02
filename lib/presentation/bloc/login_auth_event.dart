part of 'login_auth_bloc.dart';

abstract class LoginAuthEvent extends Equatable {
  const LoginAuthEvent();

  @override
  List<Object> get props => [];
}

class GetDataForFacebookLogin extends LoginAuthEvent {}

class GetDataForGoogleLogin extends LoginAuthEvent {}

class GetDataForEmailAndPassLogin extends LoginAuthEvent {
  final String email;
  final String pass;
  GetDataForEmailAndPassLogin(
    this.email,
    this.pass,
  );

  @override
  List<Object> get props => [email,pass];
}
