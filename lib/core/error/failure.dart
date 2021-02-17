import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

//Type of Failure

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}
