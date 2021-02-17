import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../model/login_model.dart';

abstract class LoginDataSources {
  ///Call Google Api for OAuth
  ///
  ///Using Firebase Auth SDK
  Future<LoginModel> getGoogleLogin();

  ///Call Email And Password Api for OAuth
  ///
  ///Using Firebase Auth SDK
  Future<LoginModel> getEmailAndPassLogin(String email, String pass);

  ///Call Facebook Api for OAuth
  ///
  ///Using Firebase Auth SDK
  Future<LoginModel> getFacebookLogin();
}

class LoginDataSourcesImp implements LoginDataSources {
  @override
  Future<LoginModel> getEmailAndPassLogin(String email, String pass) {
    throw UnimplementedError();
  }

  @override
  Future<LoginModel> getFacebookLogin() async {
    try {
      final AccessToken accessToken = await FacebookAuth.instance.login(
        permissions: [
          'email',
          'public_profile',
          'user_birthday',
          'user_friends',
          'user_gender',
          'user_link',
        ],
        loginBehavior: LoginBehavior.DIALOG_ONLY,
      );
      print(accessToken);

      final FacebookAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {}

    final userData = await FacebookAuth.instance.getUserData();

    return Future.value();
  }

  @override
  Future<LoginModel> getGoogleLogin() {
    // TODO: implement getGoogleLogin
    throw UnimplementedError();
  }
}
