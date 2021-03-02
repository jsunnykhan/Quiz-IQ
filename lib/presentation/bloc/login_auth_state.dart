part of 'login_auth_bloc.dart';

abstract class LoginAuthState extends Equatable {
  const LoginAuthState();

  @override
  List<Object> get props => [];
}

class Empty extends LoginAuthState {}

class Loading extends LoginAuthState {}

class Loaded extends LoginAuthState {
  final LoginEntity loginEntity;

  Loaded({this.loginEntity});

  @override
  List<Object> get props => [loginEntity];
}

class Error extends LoginAuthState {
  final String message;
  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
