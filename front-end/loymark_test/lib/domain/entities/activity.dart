// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str) as Map<String, dynamic>);

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  Activity({
    this.id,
    this.userId,
    this.activity,
    this.createDate,
  });
  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'] as int,
        userId: json['userId'] as int,
        activity: json['activity'] as String,
        createDate: json['createDate'] != null ? DateTime.parse(json['createDate'] as String) : null,
      );

  final int id;
  final int userId;
  final String activity;
  final DateTime createDate;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'activity': activity,
        'createDate': createDate.toIso8601String(),
      };
}
