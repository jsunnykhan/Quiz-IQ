import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_iq/data/datasource/login_datasources.dart';


class MockFireBaseUser extends Mock implements FirebaseAuth {}

void main() {
  MockFireBaseUser mockFireBaseUser;
  LoginDataSourcesImp loginDataSources;

  setUp(() {
    mockFireBaseUser = FirebaseAuth.instance;
    
  });
}

