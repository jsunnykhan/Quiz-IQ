import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_iq/core/error/exceptions.dart';
import 'package:quiz_iq/core/error/failure.dart';
import 'package:quiz_iq/core/platform/network_info.dart';
import 'package:quiz_iq/data/datasource/login_datasources.dart';
import 'package:quiz_iq/data/datasource/login_local_datasources.dart';
import 'package:quiz_iq/data/model/login_model.dart';
import 'package:quiz_iq/data/repository/login_repository_imp.dart';
import 'package:quiz_iq/domain/entity/login_entity.dart';


class MockLoginDataSources extends Mock implements LoginDataSources {}

class MockLoginLocalDataSources extends Mock implements LoginLocalDataSources {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockLoginDataSources mockLoginDataSources;
  MockLoginLocalDataSources mockLoginLocalDataSources;
  MockNetworkInfo mockNetworkInfo;
  LoginRepoImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockLoginDataSources = MockLoginDataSources();
    mockLoginLocalDataSources = MockLoginLocalDataSources();
    repository = LoginRepoImpl(
      dataSource: mockLoginDataSources,
      localDataSources: mockLoginLocalDataSources,
      networkInfo: mockNetworkInfo,
    );
  });

  

 

  void runTestOffline(Function body) {
    group('1.2 Offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  void runTestOnline(Function body) {
    group('1.1 Online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

//! For Email and Password OAuth
  group('1. getEmailAndPassLogin', () {
    final tEmail = 'test@gmail.com';
    final tPass = '123456';

    final tLoginModel = LoginModel(
      email: tEmail,
      name: 'sunny',
      photoUrl: '123.jpg',
    );
    final LoginEntity tLoginEntity = tLoginModel;
    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //act
        repository.getEmailAndPassLogin(tEmail, tPass);
        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );
//! when Device is Online
    runTestOnline(() {
      test(
        '1.1.1 should return Auth Data when call the getEmailandPass is success',
        () async {
          //arrange
          when(mockLoginDataSources.getEmailAndPassLogin(any, any))
              .thenAnswer((_) async => tLoginModel);
          //act
          final result = await repository.getEmailAndPassLogin(tEmail, tPass);
          //assert
          verify(mockLoginDataSources.getEmailAndPassLogin(tEmail, tPass));
          expect(result, equals(Right(tLoginEntity)));
        },
      );

      test(
        '1.1.2 should return Auth Data locally when call the getEmailandPass is success',
        () async {
          //arrange
          when(mockLoginDataSources.getEmailAndPassLogin(any, any))
              .thenAnswer((_) async => tLoginModel);
          //act
          await repository.getEmailAndPassLogin(tEmail, tPass);
          //assert
          verify(mockLoginDataSources.getEmailAndPassLogin(tEmail, tPass));
          verify(mockLoginLocalDataSources.cacheAuthDataInLocal(tLoginModel));
        },
      );

      test(
        '1.1.3should Throws Server Exceptions when call the getEmailandPass is UnSuccess',
        () async {
          //arrange
          when(mockLoginDataSources.getEmailAndPassLogin(any, any))
              .thenThrow(ServerException());
          //act
          final result = await repository.getEmailAndPassLogin(tEmail, tPass);
          //assert
          verify(mockLoginDataSources.getEmailAndPassLogin(tEmail, tPass));
          verifyZeroInteractions(mockLoginLocalDataSources);
          expect(result, equals(Left(ServerFailure())));
          //verifyZeroInteractions(mockLoginLocalDataSources);
        },
      );
    });

//! when Device is offline
    runTestOffline(() {
      test(
        'should return Network failure if there is no internet',
        () async {
          //arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          //act
          final result = await repository.getEmailAndPassLogin(tEmail, tPass);
          //assert
          verifyZeroInteractions(mockLoginDataSources);
          verifyZeroInteractions(mockLoginLocalDataSources);
          verify(mockNetworkInfo.isConnected);
          expect(result, Left(NetworkFailure()));
        },
      );
    });
  });

//! Get FaceBook Auth

  group('2. getFacebookLogin', () {
    final tEmail = 'test@gmail.com';

    final tLoginModel = LoginModel(
      email: tEmail,
      name: 'sunny',
      photoUrl: '123.jpg',
    );
    final LoginEntity tLoginEntity = tLoginModel;
    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //act
        repository.getFacebookLogin();
        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );
//! when Device is Online
    runTestOnline(() {
      test(
        '2.1.1 should return Auth Data when call the Facebook Auth is success',
        () async {
          //arrange
          when(mockLoginDataSources.getFacebookLogin())
              .thenAnswer((_) async => tLoginModel);
          //act
          final result = await repository.getFacebookLogin();
          //assert
          verify(mockLoginDataSources.getFacebookLogin());
          expect(result, equals(Right(tLoginEntity)));
        },
      );

      test(
        '2.1.2 should return Auth Data locally when call the Facebook Login is success',
        () async {
          //arrange
          when(mockLoginDataSources.getFacebookLogin())
              .thenAnswer((_) async => tLoginModel);
          //act
          await repository.getFacebookLogin();
          //assert
          verify(mockLoginDataSources.getFacebookLogin());
          verify(mockLoginLocalDataSources.cacheAuthDataInLocal(tLoginModel));
        },
      );

      test(
        '2.1.3 should Throws Server Exceptions when call the Facebook Login is UnSuccess',
        () async {
          //arrange
          when(mockLoginDataSources.getFacebookLogin())
              .thenThrow(ServerException());
          //act
          final result = await repository.getFacebookLogin();
          //assert
          verify(mockLoginDataSources.getFacebookLogin());
          verifyZeroInteractions(mockLoginLocalDataSources);
          expect(result, equals(Left(ServerFailure())));
          //verifyZeroInteractions(mockLoginLocalDataSources);
        },
      );
    });

//! when Device is offline

    runTestOffline(() {
      test(
        'should return Network failure if there is no internet',
        () async {
          //arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          //act
          final result = await repository.getFacebookLogin();
          //assert
          verifyZeroInteractions(mockLoginDataSources);
          verifyZeroInteractions(mockLoginLocalDataSources);
          verify(mockNetworkInfo.isConnected);
          expect(result, Left(NetworkFailure()));
        },
      );
    });
  });

  //! Get Google Auth

  group('3. getGoogleLogin', () {
    final tEmail = 'test@gmail.com';

    final tLoginModel = LoginModel(
      email: tEmail,
      name: 'sunny',
      photoUrl: '123.jpg',
    );
    final LoginEntity tLoginEntity = tLoginModel;
    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //act
        repository.getGoogleLogin();
        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );
//! when Device is Online
    runTestOnline(() {
      test(
        '3.1.1 should return Auth Data when call the Google Auth is success',
        () async {
          //arrange
          when(mockLoginDataSources.getGoogleLogin())
              .thenAnswer((_) async => tLoginModel);
          //act
          final result = await repository.getGoogleLogin();
          //assert
          verify(mockLoginDataSources.getGoogleLogin());
          expect(result, equals(Right(tLoginEntity)));
        },
      );

      test(
        '3.1.2 should return Auth Data locally when call the Google Login is success',
        () async {
          //arrange
          when(mockLoginDataSources.getGoogleLogin())
              .thenAnswer((_) async => tLoginModel);
          //act
          await repository.getGoogleLogin();
          //assert
          verify(mockLoginDataSources.getGoogleLogin());
          verify(mockLoginLocalDataSources.cacheAuthDataInLocal(tLoginModel));
        },
      );

      test(
        '3.1.3should Throws Server Exceptions when call the Google Login is UnSuccess',
        () async {
          //arrange
          when(mockLoginDataSources.getGoogleLogin())
              .thenThrow(ServerException());
          //act
          final result = await repository.getGoogleLogin();
          //assert
          verify(mockLoginDataSources.getGoogleLogin());
          verifyZeroInteractions(mockLoginLocalDataSources);
          expect(result, equals(Left(ServerFailure())));
          //verifyZeroInteractions(mockLoginLocalDataSources);
        },
      );
    });

//! when Device is offline

    runTestOffline(() {
      test(
        'should return Network failure if there is no internet',
        () async {
          //arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          //act
          final result = await repository.getGoogleLogin();
          //assert
          verifyZeroInteractions(mockLoginDataSources);
          verifyZeroInteractions(mockLoginLocalDataSources);
          verify(mockNetworkInfo.isConnected);
          expect(result, Left(NetworkFailure()));
        },
      );
    });
  });


  group('4. get Auth Data', () {
    final tEmail = 'test@gmail.com';
    final tLoginModel = LoginModel(
      email: tEmail,
      name: 'sunny',
      photoUrl: '123.jpg',
    );

    final LoginEntity tLoginEntity = tLoginModel;

    test(
      '4.1. should return Auth Data when call the Local Auth File',
      () async {
        //arrange
        when(mockLoginLocalDataSources.getAuthDataFromLocal())
            .thenAnswer((_) async => tLoginModel);
        //act
        final result = await repository.getAuthData();
        //assert
        expect(result, equals(Right(tLoginEntity)));
      },
    );

       test(
      '4.2. should throws Cache Exceptions when local data is null ',
      () async {
        //arrange
        when(mockLoginLocalDataSources.getAuthDataFromLocal())
            .thenThrow(CacheException());
        //act
        final result = await repository.getAuthData();
        //assert
        verify(mockLoginLocalDataSources.getAuthDataFromLocal());
        expect(result, equals(Left(CacheFailure())));
      },
    );


  });
}
