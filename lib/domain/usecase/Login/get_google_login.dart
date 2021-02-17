import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entity/login_entity.dart';

import '../../repository/login_repository.dart';

class GetGoogleLogin {
  final LoginRepo repository;

  GetGoogleLogin(this.repository);

  Future<Either<Failure, LoginEntity>> call() async {
    return await repository.getGoogleLogin();
  }
}
