import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../core/error/failure.dart';
import '../../entity/login_entity.dart';
import '../../repository/login_repository.dart';

class GetEmailPassLogin {
  final LoginRepo repository;

  GetEmailPassLogin(this.repository);

  Future<Either<Failure, LoginEntity>> call({
    @required String email,
    @required String pass,
  }) async {
    return await repository.getEmailAndPassLogin(email, pass);
  }
}
