import 'package:flutter/material.dart';

class ApiListResponse<T> {
  ApiListResponse({@required this.items, @required this.totalItems});
  final List<T> items;
  final int totalItems;
}
