// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str) as Map<String, dynamic>);

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.birthday,
    this.phone,
    this.country,
    this.receiveInfo,
    this.status,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        name: json['name'] as String,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
        birthday: json['birthday'] != null ? DateTime.parse(json['birthday'] as String) : null,
        phone: json['phone'] as String,
        country: json['country'] as String,
        receiveInfo: (json['receiveInfo'] is bool ? json['receiveInfo'] : json['receiveInfo'] == 1) as bool,
        status: (json['status'] is bool ? json['status'] : json['status'] == 1) as bool,
      );
  final int id;
  final String name;
  final String lastName;
  final String email;
  final DateTime birthday;
  final String phone;
  final String country;
  final bool receiveInfo;
  final bool status;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'email': email,
        'birthday':
            '${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}',
        'phone': phone,
        'country': country,
        'receiveInfo': receiveInfo,
      };

  String get fullName {
    return '$name $lastName';
  }
}
