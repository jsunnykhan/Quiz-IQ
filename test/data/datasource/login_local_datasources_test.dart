import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_iq/core/error/exceptions.dart';
import 'package:quiz_iq/data/datasource/login_local_datasources.dart';
import 'package:quiz_iq/data/model/login_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../jsonData/json_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mocksharedPreferences;
  LoginLocalDataSourcesImp dataSourcesImp;

  setUp(() {
    mocksharedPreferences = MockSharedPreferences();
    dataSourcesImp =
        LoginLocalDataSourcesImp(sharedPreferences: mocksharedPreferences);
  });

  group('getData from Local DataBase', () {
    final tLoginModel =
        LoginModel.formJson(json.decode(jsonDataReader("login.json")));
    test(
      'should return Auth Data when there is AuthData Exists',
      () async {
        //arrange
        when(mocksharedPreferences.getString(any))
            .thenReturn(jsonDataReader("login.json"));
        //act
        final result = await dataSourcesImp.getAuthDataFromLocal();
        //assert
        verify(mocksharedPreferences.getString(CACHED_AUTH_DATA));
        expect(result, equals(tLoginModel));
      },
    );

    test(
      'should throws CacheException when there is no Data exixts',
      () async {
        //arrange
        when(mocksharedPreferences.getString(any)).thenReturn(null);
        //act
        final call = dataSourcesImp.getAuthDataFromLocal;
        //assert

        expect(() => call(), throwsA(isA<CacheException>()));
      },
    );
  });

  group('CacheAuthData', () {
    final tloginModel = LoginModel(
        name: 'test', email: 'test@email.com', photoUrl: 'sdshdb.png');
    test(
      'should store auth data in local Store',
      () async {
        //act
        dataSourcesImp.cacheAuthDataInLocal(tloginModel);
        //assert
        verify(mocksharedPreferences.setString(
            CACHED_AUTH_DATA, json.encode(tloginModel.toJson())));
      },
    );
  });
}
