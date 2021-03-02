import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/login_entity.dart';
import '../../domain/usecase/Login/get_email_paas_login.dart';
import '../../domain/usecase/Login/get_facebook_login.dart';
import '../../domain/usecase/Login/get_google_login.dart';

part 'login_auth_event.dart';
part 'login_auth_state.dart';

class LoginAuthBloc extends Bloc<LoginAuthEvent, LoginAuthState> {
  final GetFacebookLogin facebookLogin;
  final GetEmailPassLogin getEmailPassLogin;
  final GetGoogleLogin getGoogleLogin;

  LoginAuthBloc({
    @required GetFacebookLogin facebook,
    @required GetEmailPassLogin emailPass,
    @required GetGoogleLogin google,
  })  : assert(facebook != null),
        assert(emailPass != null),
        assert(google != null),
        facebookLogin = facebook,
        getEmailPassLogin = emailPass,
        getGoogleLogin = google,
        super(Empty());

  @override
  Stream<LoginAuthState> mapEventToState(
    LoginAuthEvent event,
  ) async* {

    if(event is GetDataForFacebookLogin){
      
    }
  }
}
