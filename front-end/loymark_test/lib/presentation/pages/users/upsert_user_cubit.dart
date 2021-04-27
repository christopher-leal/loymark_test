import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/core/utils/utils.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/domain/usecases/upsert_user_usecase.dart';

class UpsertUserState {
  UpsertUserState(this.user,
      {this.selectedCountry = '', this.error, this.isLoading = false, this.isSuccess = false, this.receiveNotification = false});
  final String error;
  final bool isLoading;
  final bool isSuccess;
  final bool receiveNotification;
  final String selectedCountry;
  final User user;
}

class UpsertUserCubit extends Cubit<UpsertUserState> {
  UpsertUserCubit(this._upsertUserUseCase) : super(UpsertUserState(null));
  final UpsertUserUseCase _upsertUserUseCase;
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdayController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  DateTime birthday;

  RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  Future<void> upsertUser() async {
    if (nameController.text.trim().isEmpty) {
      print('nameController vacio');
      emit(UpsertUserState(state.user,
          error: 'El nombre es requerido', receiveNotification: state.receiveNotification, selectedCountry: state.selectedCountry));
      return;
    }
    if (lastNameController.text.trim().isEmpty) {
      print('lastNameController vacio');
      emit(UpsertUserState(state.user,
          error: 'El apellido es requerido', receiveNotification: state.receiveNotification, selectedCountry: state.selectedCountry));
      return;
    }
    if (emailController.text.trim().isEmpty) {
      print('emailController vacio');
      emit(UpsertUserState(state.user,
          error: 'El email es requerido', receiveNotification: state.receiveNotification, selectedCountry: state.selectedCountry));
      return;
    }
    if (!emailRegex.hasMatch(emailController.text)) {
      print('regex');
      emit(UpsertUserState(state.user,
          error: 'El email es no es valido', receiveNotification: state.receiveNotification, selectedCountry: state.selectedCountry));
      return;
    }
    if (birthdayController.text.trim().isEmpty || birthday == null) {
      print('birthdayController vacio');
      emit(UpsertUserState(state.user,
          error: 'El fecha de nacimiento es requerida', receiveNotification: state.receiveNotification, selectedCountry: state.selectedCountry));
      return;
    }
    if (state.selectedCountry.isEmpty) {
      print('selectedCountry vacio');
      emit(UpsertUserState(state.user,
          error: 'El pais es requerido', receiveNotification: state.receiveNotification, selectedCountry: state.selectedCountry));
      return;
    }
    emit(UpsertUserState(state.user, receiveNotification: state.receiveNotification, selectedCountry: state.selectedCountry, isLoading: true));

    final user = User(
      id: state.user?.id,
      birthday: birthday,
      country: state.selectedCountry,
      email: emailController.text,
      lastName: lastNameController.text,
      name: nameController.text,
      phone: phoneController.text,
      receiveInfo: state.receiveNotification,
    );
    final success = await _upsertUserUseCase.upsertUser(user);
    if (success) {
      return emit(UpsertUserState(null, isSuccess: true));
    }
    emit(UpsertUserState(state.user, receiveNotification: state.receiveNotification, selectedCountry: state.selectedCountry));
  }

  void changeReceiveNotification() =>
      emit(UpsertUserState(state.user, receiveNotification: !state.receiveNotification, selectedCountry: state.selectedCountry));
  void changeCountry(String country) => emit(UpsertUserState(state.user, receiveNotification: state.receiveNotification, selectedCountry: country));

  void init(User user) {
    if (user != null) {
      emit(UpsertUserState(null, isLoading: true));
      nameController.text = user.name;
      lastNameController.text = user.lastName;
      emailController.text = user.email;
      birthday = user.birthday;
      birthdayController.text = Utils.formatDateWithoutTime(datetime: user.birthday);
      phoneController.text = user.phone;
      countryController.text = user.country;
      emit(UpsertUserState(user, receiveNotification: user.receiveInfo));
    }
  }
}
