import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entity/login_entity.dart';
import '../../repository/login_repository.dart';

class GetFacebookLogin {
  final LoginRepo repository;

  GetFacebookLogin(this.repository);

  Future<Either<Failure, LoginEntity>> call() async {
    return await repository.getFacebookLogin();
  }
}
