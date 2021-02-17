import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/exceptions.dart';
import '../model/login_model.dart';

abstract class LoginLocalDataSources {
  ///Get the Cache Auth id
  ///
  ///or Throws [NoLocalAuthException] if no one login
  Future<LoginModel> getAuthDataFromLocal();

  ///set the Cache Auth id
  ///
  ///or Throws [CacheException]
  Future<void> cacheAuthDataInLocal(LoginModel model);
}

const CACHED_AUTH_DATA = 'CACHED_AUTH_DATA';

class LoginLocalDataSourcesImp implements LoginLocalDataSources {
  SharedPreferences sharedPreferences;
  LoginLocalDataSourcesImp({@required this.sharedPreferences});
  @override
  Future<void> cacheAuthDataInLocal(LoginModel model) {
    return sharedPreferences.setString(
      CACHED_AUTH_DATA,
      json.encode(model.toJson()),
    );
  }

  @override
  Future<LoginModel> getAuthDataFromLocal() {
    final jsonString = sharedPreferences.getString(CACHED_AUTH_DATA);
    if (jsonString != null) {
      return Future.value(LoginModel.formJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
