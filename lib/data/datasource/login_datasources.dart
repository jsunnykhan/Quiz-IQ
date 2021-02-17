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
      final AccessToken re = await FacebookAuth.instance.login();
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
      print('Token :::: ${accessToken.token}');
      final FacebookAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      final data = await FirebaseAuth.instance.signInWithCredential(credential);
      final x = await FirebaseAuth.instance.currentUser;
      print(x.uid);
    } catch (e) {
      print('Error $e');
    }

    final userData = await FacebookAuth.instance.getUserData();
    // print(userData);
    return Future.value();
  }

  @override
  Future<LoginModel> getGoogleLogin() {
    // TODO: implement getGoogleLogin
    throw UnimplementedError();
  }
}
