import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../init.dart';

// 1개의 파일 업로드
Future<void> uploadVoiceFile(file, filename, email, name) async {

  var bytes = utf8.encode(email);
  var urlBase = base64Encode(bytes);

  var bytesName = utf8.encode(name);
  var urlBaseName = base64Encode(bytesName);

  print(filename);

  var data = FormData.fromMap({
    "audio": await MultipartFile.fromFile(
      file.path,
      filename: filename,
    )
  });

  Dio dio = new Dio();

  dio.post('https://api-test.nearbycrew.com:8443/voice/register/$urlBase/$urlBaseName',
      data:data,
      options: Options(contentType:Headers.formUrlEncodedContentType)).then((res){
    var jsonResponse = jsonDecode(res.toString());
    print(jsonResponse);
  });

}