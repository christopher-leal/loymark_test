import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:loymark_test/domain/entities/country.dart';

class GetCountriesUseCase {
  Future<List<Country>> getCountries() async {
    final data = await rootBundle.loadString('assets/json/countries.json');
    final decoded = json.decode(data) as List<dynamic>;
    final countries = decoded.map((e) => Country.fromJson(e as Map<String, dynamic>)).toList();
    return countries;
  }
}
