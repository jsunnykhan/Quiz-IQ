import 'dart:io';

String jsonDataReader(String path) =>
    File('test/jsonData/$path').readAsStringSync();
