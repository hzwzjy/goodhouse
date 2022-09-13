import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goodhouse/common/utils/utils.dart';
import 'package:goodhouse/common/values/server.dart';
import 'package:goodhouse/common/widgets/widgets.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;
  late Dio dio;
  HttpUtil._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: SERVER_API_URL,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
    dio = new Dio(options);
    // 添加拦截器
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        ErrorEntity eInfo = createErrorEntity(e);
        // 错误提示
        toastInfo(msg:eInfo.message);
        // 错误交互处理
        var context = e.requestOptions.extra["context"];
        if (context != null) {
          switch (eInfo.code) {
            case 401: // 没有权限 重新登录
              goLoginPage(context);
              break;
            default:
          }
        }
      },
    ));
  }
  Future get(
    String path, {
    BuildContext? context,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "context": context,
    });
    requestOptions.headers = requestOptions.headers ?? {};
    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  Future post(
    String path, {
    dynamic data,
    BuildContext? context,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "context": context,
    });
    requestOptions.headers = requestOptions.headers ?? {};
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }
}

/*
   * error统一处理
   */
// 错误信息
ErrorEntity createErrorEntity(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      {
        return ErrorEntity(code: -1, message: "请求取消");
      }
    case DioErrorType.connectTimeout:
      {
        return ErrorEntity(code: -1, message: "连接超时");
      }
    case DioErrorType.sendTimeout:
      {
        return ErrorEntity(code: -1, message: "请求超时");
      }
    case DioErrorType.receiveTimeout:
      {
        return ErrorEntity(code: -1, message: "响应超时");
      }
    case DioErrorType.response:
      {
        try {
          int errCode = error.response!.statusCode!;
          // String errMsg = error.response.statusMessage;
          // return ErrorEntity(code: errCode, message: errMsg);
          switch (errCode) {
            case 400:
              {
                return ErrorEntity(code: errCode, message: "请求语法错误");
              }
            case 401:
              {
                return ErrorEntity(code: errCode, message: "没有权限");
              }
            case 403:
              {
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              }
            case 404:
              {
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              }
            case 405:
              {
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              }
            case 500:
              {
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              }
            case 502:
              {
                return ErrorEntity(code: errCode, message: "无效的请求");
              }
            case 503:
              {
                return ErrorEntity(code: errCode, message: "服务器挂了");
              }
            case 505:
              {
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              }
            default:
              {
                // return ErrorEntity(code: errCode, message: "未知错误");
                return ErrorEntity(
                    code: errCode, message: error.response!.statusMessage!);
              }
          }
        } on Exception catch (_) {
          return ErrorEntity(code: -1, message: "未知错误");
        }
      }
    default:
      {
        return ErrorEntity(code: -1, message: error.message);
      }
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int code;
  String message;
  ErrorEntity({required this.code, required this.message});

  String toString() {
    return "Exception: code $code, $message";
  }
}
