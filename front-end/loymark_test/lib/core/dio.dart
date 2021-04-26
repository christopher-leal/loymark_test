import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loymark_test/core/environment.dart';

final dio = Dio(BaseOptions(
  baseUrl: Environment.apiUrl,
  contentType: ContentType.json.toString(),
));
