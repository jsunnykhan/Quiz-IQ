import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_iq/domain/entity/login_entity.dart';
import 'package:quiz_iq/domain/repository/login_repository.dart';
import 'package:quiz_iq/domain/usecase/Login/get_facebook_login.dart';


class MockLoginRepository extends Mock implements LoginRepo {}

void main() {
  GetFacebookLogin usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = GetFacebookLogin(mockLoginRepository);
  });

  final tloginResult = LoginEntity(
    name: 'name',
    email: 'a.bcde@gmail.com',
    photoUrl: 'abcd.jpg',
  );
  test(
    '1. should  get Facebook Login from Login Repository',
    () async {
      //arrange
      when(mockLoginRepository.getFacebookLogin())
          .thenAnswer((_) async => Right(tloginResult));
      //act
      final result = await usecase();
      //assert
      expect(result, Right(tloginResult));
      verify(mockLoginRepository.getFacebookLogin());
      verifyNoMoreInteractions(mockLoginRepository);
    },
  );
}
