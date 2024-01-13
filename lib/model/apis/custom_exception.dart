import 'package:flutter/material.dart';
import 'package:users_details_mvvm/main.dart';

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    final SnackBar snackBar = SnackBar(content: Text(_message), backgroundColor: Colors.red, duration: const Duration(seconds: 3), behavior: SnackBarBehavior.floating);
    snackBarKey.currentState?.showSnackBar(snackBar);
    return "$_prefix $_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "Error During Communication:");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
