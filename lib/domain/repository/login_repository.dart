import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entity/login_entity.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginEntity>> getGoogleLogin();
  Future<Either<Failure, LoginEntity>> getEmailAndPassLogin(
      String email, String pass);
  Future<Either<Failure, LoginEntity>> getFacebookLogin();

  Future <Either<Failure, LoginEntity>> getAuthData();
}
