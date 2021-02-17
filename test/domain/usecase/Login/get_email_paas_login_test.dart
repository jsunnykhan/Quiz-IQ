import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:dartz/dartz.dart';
import 'package:quiz_iq/domain/entity/login_entity.dart';
import 'package:quiz_iq/domain/repository/login_repository.dart';
import 'package:quiz_iq/domain/usecase/Login/get_email_paas_login.dart';


class MockLoginRepository extends Mock implements LoginRepo {}

void main() {
  GetEmailPassLogin usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = GetEmailPassLogin(mockLoginRepository);
  });
  final temail = 'a.bcde@gmail.com';
  final tpass = '123456';
  final tloginResult = LoginEntity(
    name: 'name',
    email: 'a.bcde@gmail.com',
    photoUrl: 'abcd.jpg',
  );

  test(
    '2. should get Email Login from repository',
    () async {
      //arrange
      when(mockLoginRepository.getEmailAndPassLogin(any, any))
          .thenAnswer((_) async => Right(tloginResult));
      //act
      final result = await usecase(
        email: temail,
        pass: tpass,
      );
      //assert
      expect(result, Right(tloginResult));
      verify(mockLoginRepository.getEmailAndPassLogin(temail, tpass));
      verifyNoMoreInteractions(mockLoginRepository);
    },
  );
}
