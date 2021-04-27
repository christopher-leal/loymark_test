import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/domain/entities/country.dart';
import 'package:loymark_test/domain/usecases/get_countries_usecase.dart';

class CountriesCubit extends Cubit<List<Country>> {
  CountriesCubit(this._countriesUseCase) : super([]);

  final GetCountriesUseCase _countriesUseCase;

  Future<void> getCountries() async {
    final countries = await _countriesUseCase.getCountries();
    emit(countries);
  }
}
