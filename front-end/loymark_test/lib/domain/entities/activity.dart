// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

import 'package:loymark_test/domain/entities/user.dart';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str) as Map<String, dynamic>);

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  Activity({this.id, this.userId, this.activity, this.createDate, this.user});
  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'] as int,
        userId: json['userId'] as int,
        activity: json['activity'] as String,
        createDate: json['createDate'] != null ? DateTime.parse(json['createDate'] as String) : null,
        user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
      );

  final int id;
  final int userId;
  final String activity;
  final DateTime createDate;
  final User user;
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'activity': activity,
        'createDate': createDate.toIso8601String(),
      };
}
