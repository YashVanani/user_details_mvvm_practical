import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:users_details_mvvm/utils/app_color.dart';

class AppConstant {
  static const String tblUserDetails = 'tbl_user_details';
  static const String dateFormatStyle = 'dd MMM y';
  static const String monthDateFormatStyle = 'MMMM d, y';
  static const String todayString = 'Today';
  static const String yesterdayString = 'Yesterday';

  static dateFormat(String date) {
    return DateFormat(dateFormatStyle).format(DateTime.parse(date));
  }

  static snackBarStyle(String text, Color color) {
    return SnackBar(content: Text(text), backgroundColor: color, duration: const Duration(seconds: 1), behavior: SnackBarBehavior.floating);
  }

  static divider({Color? color}) {
    return Divider(
      color: color ?? Colors.black,
    );
  }

  static circularProgressIndicator({Color? color}) {
    return CircularProgressIndicator(color: color ?? AppColors.secondaryColor);
  }

  static mainTextStyle({double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(fontSize: fontSize ?? 16, color: Colors.black, fontWeight: fontWeight ?? FontWeight.w400);
  }

  static String formatDate(String inputDate) {
    DateTime currentDate = DateTime.now();
    DateTime parsedDate = DateTime.parse(inputDate);
    Duration difference = currentDate.difference(parsedDate);

    if (difference.inDays == 0) {
      return todayString;
    } else if (difference.inDays == 1) {
      return yesterdayString;
    } else {
      return DateFormat(monthDateFormatStyle).format(parsedDate);
    }
  }
}
