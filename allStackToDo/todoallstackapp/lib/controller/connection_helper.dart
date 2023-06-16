import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class ConnectionHelper {
  Future<Response<dynamic>?> fetchData(
    String method,
    String url, {
    dynamic data,
    dynamic query,
    dynamic header,
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
      late dynamic response;
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
        response = await dio.post(url,
            queryParameters: query,
            data: data,
            options: Options(
              headers: header,
              sendTimeout: const Duration(milliseconds: 30000),
              receiveTimeout: const Duration(milliseconds: 30000),
            ));
        print(response);
      } else if (method.toUpperCase() == "PUT") {
        response = await dio.put(url,
            queryParameters: query,
            data: data,
            options: Options(
              headers: header,
              sendTimeout: const Duration(milliseconds: 30000),
              receiveTimeout: const Duration(milliseconds: 30000),
            ));
      } else if (method.toUpperCase() == "PATCH") {
        response = await dio.patch(url,
            queryParameters: query,
            data: data,
            options: Options(
              headers: header,
              sendTimeout: const Duration(milliseconds: 30000),
              receiveTimeout: const Duration(milliseconds: 30000),
            ));
      } else if (method.toUpperCase() == "DELETE") {
        response = await dio.delete(url,
            queryParameters: query,
            data: data,
            options: Options(
              headers: header,
              sendTimeout: const Duration(milliseconds: 30000),
              receiveTimeout: const Duration(milliseconds: 30000),
            ));
      } else {
        if (kDebugMode) {
          print("no method mentioned");
        }
      }

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
      return error.response;
    }
  }
}
