import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  static final client = http.Client();
  static final storage = FlutterSecureStorage();
  static Future<String> post(var body, String endpoint) async {
    var token = await getToken("bearerToken");
    log(endpoint);
    log(body);
    log("Bearer ${token}");
    try {
      var response = await client.post(buildUrl(endpoint),
          body: body,
          headers: {
            "Content-type": "application/json",
            "authorization": "Bearer $token"
          });
      log(response.statusCode.toString());
      log(response.body);
      return response.body;
    } catch (e) {
      var response = await client.post(buildUrl(endpoint),
          body: body,
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          });
      log(response.statusCode.toString());
      log(response.body);
      return response.body;
    }
  }

  static Future<String> postForm(var photo, String endpoint, int assignment_id,
      int student_id, String desc) async {
    var token = await getToken("bearerToken");
    var formData = FormData.fromMap({
      "assignment_id": assignment_id,
      "student_id": student_id,
      "description": desc,
      "assign_docs[]": [
        for (var i = 0; i < photo.length; i++)
          await MultipartFile.fromFile(photo[i].path,
              filename: photo[i].path.split('/').last),
      ],
    });
    Dio dio = new Dio();
    dio.options.headers['content-type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${token}";
    var response = await dio.post(
      buildImageUrl(endpoint),
      data: formData,
    );
    log(response.data);
    return response.data;
  }

  static Uri buildUrl(String endpoint) {
    //String host = "https://synramtechnology.com/lahs/public/api/";
    String host = "https://synramtechnology.com/lahs/public/api/";
    final apiPath = host + endpoint;
    return Uri.parse(apiPath);
  }

  static String buildImageUrl(String endpoint) {
    String host = "https://synramtechnology.com/lahs/public/api/";
    final apiPath = host + endpoint;
    return apiPath;
  }

  static void storeToken(String key, String token) async {
    await storage.write(key: key, value: token);
  }

  static Future checkToken(String key) async {
    return await storage.containsKey(key: key);
  }

  static Future<String?> getToken(String key) async {
    return await storage.read(key: key);
  }

  static void removeToken() async {
    await storage.deleteAll();
  }

  Future<bool> checkConnectivity() async {
    try {
      bool isConnected;
      var connectivity = await (Connectivity().checkConnectivity());
      if (connectivity == ConnectivityResult.mobile) {
        isConnected = true;
      } else if (connectivity == ConnectivityResult.wifi) {
        isConnected = true;
      } else {
        isConnected = false;
      }

      if (isConnected) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            isConnected = true;
          }
        } on SocketException catch (_) {
          isConnected = false;
        }
      }

      return isConnected;
    } catch (e) {
      log('Exception - NetworkHandler.dart - checkConnectivity(): ' +
          e.toString());
    }
    return false;
  }
}