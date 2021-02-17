import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/platform/network_info.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/repository/login_repository.dart';
import '../datasource/login_datasources.dart';
import '../datasource/login_local_datasources.dart';

class LoginRepoImpl implements LoginRepo {
  final NetworkInfo networkInfo;
  final LoginDataSources dataSource;
  final LoginLocalDataSources localDataSources;

  LoginRepoImpl({
    @required this.networkInfo,
    @required this.dataSource,
    @required this.localDataSources,
  });

  @override
  Future<Either<Failure, LoginEntity>> getEmailAndPassLogin(
      String email, String pass) async {
    return await _getLoginMethod(() {
      return dataSource.getEmailAndPassLogin(email, pass);
    });
  }

  @override
  Future<Either<Failure, LoginEntity>> getFacebookLogin() async {
    return await _getLoginMethod(() {
      return dataSource.getFacebookLogin();
    });
  }

  @override
  Future<Either<Failure, LoginEntity>> getGoogleLogin() async {
    return await _getLoginMethod(() {
      return dataSource.getGoogleLogin();
    });
  }

  @override
  Future<Either<Failure, LoginEntity>> getAuthData() async {
    try {
      final cacheData = await localDataSources.getAuthDataFromLocal();
      return Right(cacheData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, LoginEntity>> _getLoginMethod(
      Future<LoginEntity> Function() getLoginName) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await getLoginName();
        localDataSources.cacheAuthDataInLocal(data);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(NetworkFailure());
  }
}
