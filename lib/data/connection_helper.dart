import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';



class ConnectionHelper {
  Future<Response<dynamic>?> getData(
    String url, {
    Map<String, dynamic>? query,
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
      var response = await dio.get(url,
          //queryParameters: query,
          options: Options(
            sendTimeout: const Duration(milliseconds: 10000),
            receiveTimeout: const Duration(milliseconds: 10000),
          ));

      // Ending Timer
      DateTime etime = DateTime.now();

      // Calculating Time
      Duration diff = etime.difference(stime);

      // Printing Results
      print(url + ": " + diff.inMilliseconds.toString() + " Milliseconds");

      return response;
    } on DioError catch (error) {
      return error.response;
    }
  }

  Future<Response<dynamic>?> postData(String url, dynamic data) async {
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

      var response = await dio.post(
        url,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          sendTimeout: const Duration(milliseconds: 10000),
          receiveTimeout: const Duration(milliseconds: 10000),
        ),
      );

      // Ending Timer
      DateTime etime = DateTime.now();

      // Calculating Time
      Duration diff = etime.difference(stime);

      // Printing Results
      print(url + ": " + diff.inMilliseconds.toString() + " Milliseconds");

      return response;
    } on DioError catch (error) {
      if (error.response != null) {
        return error.response;
      } else {
        print(error);
      }
    }
    return null;
  }

}
