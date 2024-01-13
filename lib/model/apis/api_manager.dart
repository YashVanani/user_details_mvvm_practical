import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:users_details_mvvm/model/error_model.dart';
import 'custom_exception.dart';

class APIManager {
  static Future<dynamic> getAPICall(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = _response(response);
    } on SocketException catch (e) {
      log("exception ::::: $e");
      return;
    } on TimeoutException catch (_) {
      throw FetchDataException('Server Error');
    } finally {}
    return responseJson;
  }

  static _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        if (json.decode(response.body)['status'] == 0) {
          throw BadRequestException(ErrorModel.fromJson(json.decode(response.body.toString())).message);
        } else {
          var responseJson = json.decode(response.body.toString());
          return responseJson;
        }

      case 201:
        if (json.decode(response.body)['status'] == 0) {
          throw BadRequestException(ErrorModel.fromJson(json.decode(response.body.toString())).message);
        } else {
          var responseJson = json.decode(response.body.toString());
          return responseJson;
        }

      case 400:
        throw BadRequestException(ErrorModel.fromJson(json.decode(response.body.toString())).message);

      case 404:
        throw BadRequestException(ErrorModel.fromJson(json.decode(response.body.toString())).message);

      case 401:
        throw BadRequestException(ErrorModel.fromJson(json.decode(response.body.toString())).message);

      case 403:
        throw UnauthorisedException(ErrorModel.fromJson(json.decode(response.body.toString())).message);

      case 417:
        throw UnauthorisedException(ErrorModel.fromJson(json.decode(response.body.toString())).message);

      case 500:
      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
