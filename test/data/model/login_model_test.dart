import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_iq/data/model/login_model.dart';
import 'package:quiz_iq/domain/entity/login_entity.dart';


import '../../jsonData/json_reader.dart';

void main() {
  final tLoginModel = LoginModel(
    name: 'test',
    email: 'test@gmail.com',
    photoUrl: 'abc',
  );

  test(
    '3. should be a subclass of LoginEntity',
    () async {
      //assert
      expect(tLoginModel, isA<LoginEntity>());
    },
  );

  test(
    '3.1 should return a valid model when the call',
    () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(
        jsonDataReader('login.json'),
      );
      //act
      final result = LoginModel.formJson(jsonMap);
      //assert
      expect(result, tLoginModel);
    },
  );

  test(
    '3.2 should return a JSON map that contain Proper Data',
    () async {
      //arrange

      //act
      final result = tLoginModel.toJson();
      //assert
      final texpectedJson = {
        "name": "test",
        "email": "test@gmail.com",
        "photoUrl": "abc",
      };
      expect(result, texpectedJson);
    },
  );
}
