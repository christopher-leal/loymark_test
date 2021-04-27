import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static void showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text));
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  static Future navigateTo(BuildContext context, Widget page, {bool fullscreenDialog = false}) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) => page, fullscreenDialog: fullscreenDialog));
  }

  static Future navigateAndReplacementTo(BuildContext context, Widget page, {bool fullscreenDialog = false}) {
    return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => page, fullscreenDialog: fullscreenDialog));
  }

  static void navigateRemoveUntilTo(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => page), (route) => false);
  }

  static String formatDateWithoutTime({String string, DateTime datetime}) {
    if (string != null) {
      final dt0 = DateTime.parse(string);
      return DateFormat('d MMM y', 'es_MX').format(dt0);
    } else if (datetime != null) {
      return DateFormat('d MMM y', 'es_MX').format(datetime);
    }
    return '';
  }

  static String formatDate({String string, DateTime datetime}) {
    if (string != null) {
      final dt0 = DateTime.parse(string);
      return DateFormat.yMMMMEEEEd('es_MX').add_jms().format(dt0);
    } else if (datetime != null) {
      return DateFormat.yMMMMEEEEd('es_MX').add_jms().format(datetime);
    }
    return '';
  }

  static String dateWithoutTime(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static void dismissKeyboard(BuildContext context) {
    final cFocus = FocusScope.of(context);
    if (!cFocus.hasPrimaryFocus) {
      cFocus.unfocus();
    }
  }
}
