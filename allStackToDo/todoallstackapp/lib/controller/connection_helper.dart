import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionHelper {
  Future<Response<dynamic>?> fetchData(
    String method,
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
  }) async {
    try {
      // Starting Timer
      DateTime stime = DateTime.now();
      Dio dio = Dio();
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      // Request to API
      late var response;
      if (method.toUpperCase() == "GET") {
        response = await dio.get(url,
          queryParameters: query,
          data: data,
          options: Options(
            headers: header,
            sendTimeout: const Duration(milliseconds: 30000),
            receiveTimeout: const Duration(milliseconds: 30000),
          ));
      } else if (method.toUpperCase() == "POST") {
      } else if (method.toUpperCase() == "PUT") {
      } else if (method.toUpperCase() == "PATCH") {
      } else if (method.toUpperCase() == "DELETE") {
      } else {}
      var 

      // Ending Timer
      DateTime etime = DateTime.now();

      // Calculating Time
      Duration diff = etime.difference(stime);

      // Printing Results
      if (kDebugMode) {
        print("$url: ${diff.inMilliseconds} Milliseconds");
      }

      return response;
    } on DioException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      if (error.response != null) {
      } else {
        if (kDebugMode) {
          print(error);
        }
      }
      return error.response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
