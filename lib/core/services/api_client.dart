import 'package:cleanarch/core/error/failure.dart';
import 'package:cleanarch/core/services/api_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  var dio = Dio();
  var sentTimeOut = const Duration(milliseconds: 10000);
  var receiveTimeOut = const Duration(milliseconds: 25000);

  ApiClient() {
    dio.interceptors.add(PrettyDioLogger());
  }

  // GET METHOD
  Future<Response> get(
    String api,
    String? authToken,
    CancelToken? cancelToken, {
    Map<String, String>? customHeaders,
    Function(int, int)? onReceiveProgress,
    Options? options,
  }) async {
    var url = ApiConst.baseURL + api;
    var headers = hheaders(authToken ?? "", customHeaders);
    var result = await dio.get(
      url,
      options: options ??
          Options(
            headers: headers,
            sendTimeout: sentTimeOut,
            receiveTimeout: receiveTimeOut,
          ),
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
    return result;
  }

  // POST METHOD
  Future<Response> post(
    String api,
    String? authToken,
    CancelToken? cancelToken, {
    Map<String, String>? customHeaders,
    dynamic reqBody,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
    Options? options,
  }) async {
    var url = ApiConst.baseURL + api;
    var headers = hheaders(authToken ?? "", customHeaders);
    var result = await dio.post(
      url,
      data: reqBody,
      options: options ??
          Options(
            headers: headers,
            sendTimeout: sentTimeOut,
            receiveTimeout: receiveTimeOut,
          ),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
    return result;
  }

  // POST METHOD
  Future<Response> download(
    String downloadUrl,
    String filePath,
    CancelToken? cancelToken, {
    Function(int, int)? onReceiveProgress,
    Options? options,
  }) async {
    var result = await dio.download(
      downloadUrl,
      filePath,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
    return result;
  }

  // HANDLE DIO EXCEPTION
  Failure handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      debugPrint("resultError =>> No Internet Connection");
      return const DatabaseFailure("Error : No Internet Connection");
    } else if (e.type == DioExceptionType.sendTimeout) {
      debugPrint("resultError =>> Sent Timeout");
      return const DatabaseFailure("Error : Sent Timeout");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      debugPrint("resultError =>> Receive Timeout");
      return const DatabaseFailure("Error : Receive Timeout");
    } else if (e.type == DioExceptionType.connectionTimeout) {
      debugPrint("resultError =>> Connection Timeout");
      return const DatabaseFailure("Error : Connection Timeout");
    } else if (e.type == DioExceptionType.badResponse) {
      debugPrint("resultError =>> ${e.response!.statusCode}");
      if (e.response!.statusCode == 400) {
        var data = e.response!.data;
        var msg = data["message"];
        debugPrint("resultError =>> $msg");
        return DatabaseFailure("Error : $msg");
      } else if (e.response!.statusCode! > 400) {
        debugPrint("resultError =>> $e");
        return DatabaseFailure("Error : ${e.response!.statusCode}");
      } else if (e.response!.statusCode! == 500) {
        debugPrint("resultError =>> $e");
        return const DatabaseFailure("Error : Internal Server Error");
      } else {
        debugPrint("resultError =>> $e");
        return DatabaseFailure("Error : ${e.response!.statusCode}");
      }
    } else {
      debugPrint("resultError =>> $e");
      return DatabaseFailure("Error : ${e.response!.statusCode}");
    }
  }

  // HANDLE CATCH
  Failure handleCatch(e) {
    debugPrint("resultError =>> $e");
    return ServerFailure("Error : $e");
  }

  // HANDLE HEADERS
  Map<String, String> hheaders(
      String authToken, Map<String, String>? customHeaders) {
    if (customHeaders == null || customHeaders.isEmpty) {
      return {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
    } else {
      return customHeaders;
    }
  }
}
