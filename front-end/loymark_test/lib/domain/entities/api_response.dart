// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.success,
    this.statusCode,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        success: json['success'] as bool,
        statusCode: json['statusCode'] as int,
        data: json['data'],
      );
  final bool success;
  final int statusCode;
  final dynamic data;

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'data': data,
      };
}
