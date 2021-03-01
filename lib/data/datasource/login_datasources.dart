import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_iq/core/error/exceptions.dart';

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
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  //! login with Email and password
  @override
  Future<LoginModel> getEmailAndPassLogin(String email, String pass) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        throw EmailNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw PasswordNotFoundException();
      }
    }

    final currentUser = firebaseAuth.currentUser;

    final currenUserHasData =
        await fireStore.collection('users').doc(currentUser.uid).get();

    if (currenUserHasData.exists) {
      return LoginModel.formJson(currenUserHasData.data());
    } else {
      throw DatabaseException();
    }
  }

  //! login with Facebook account
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
      final FacebookAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      await firebaseAuth.signInWithCredential(credential);
      return await _registerUser();
    } catch (e) {
      throw ServerException();
    }

    return await _registerUser();
  }

  //! login with Google account
  @override
  Future<LoginModel> getGoogleLogin() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);

      return await _registerUser();
    } catch (e) {
      throw ServerException();
    }
  }

//! get Data From DB
  Future<LoginModel> _registerUser() async {
    final currentUser = firebaseAuth.currentUser;

    final model = LoginModel(
      name: currentUser.displayName,
      email: currentUser.email,
      photoUrl: currentUser.photoURL,
    );

    try {
      final currenUserHasData =
          await fireStore.collection('users').doc(currentUser.uid).get();
      if (currenUserHasData.exists) {
        fireStore
            .collection('users')
            .doc(currentUser.uid)
            .update(model.toJson())
            .then((value) => print('Update success'))
            .catchError((onError) => print(onError));
      } else {
        fireStore
            .collection('users')
            .doc(currentUser.uid)
            .set(model.toJson())
            .then((value) => print('Set success'))
            .catchError((onError) => print(onError));
      }
      return model;
    } catch (e) {
      throw DatabaseException();
    }
  }
}
  