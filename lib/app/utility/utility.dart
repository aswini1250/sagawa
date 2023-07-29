import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Utility{

static isOnlyAlphabetic({required String data}){
  final regExp = RegExp(
      r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' // <-- Notice the escaped symbols
      "'" // <-- ' is added to the expression
          ']'
  );
  RegExp numberRegexp = RegExp(r'^-?[0-9]+$');
  if(data.contains(regExp) || data.contains(numberRegexp)){
    return false;
  }else{
    return true;
  }

}

 static bool isNumeric({required String string}) {

    return double.tryParse(string) != null;
  }

  Iterable<TimeOfDay> getTimes(TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);




}



