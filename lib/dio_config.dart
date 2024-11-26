import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio createDioInstance() {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env["API_URL"]!,
      headers: {
        "api-key": dotenv.env["API_KEY"]!,
      },
      contentType: "application/json",
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      retryDelays: const [
        Duration(seconds: 30),
        Duration(seconds: 30),
        Duration(seconds: 30),
      ],
      retryEvaluator: (error, _) =>
          error.type == DioExceptionType.connectionTimeout,
    ),
  );

  return dio;
}
