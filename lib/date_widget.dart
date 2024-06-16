/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;
  final bool isJalali;

  DateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
    this.isJalali = true,
  });

  @override
  Widget build(BuildContext context) {
    final jalaliDate = Jalali.fromDateTime(date);

    return InkWell(
      child: Container(
        width: width,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  isJalali
                      ? jalaliDate.formatter.mN
                      : new DateFormat("MMM", locale)
                          .format(date)
                          .toUpperCase(),
                  style: monthTextStyle),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    isJalali
                        ? jalaliDate.formatter.d
                        : date.day.toString(), // Date
                    style: dateTextStyle,
                  ),
                ),
              ),
              Text(
                  isJalali
                      ? jalaliDate.formatter.wN
                      : new DateFormat("E", locale)
                          .format(date)
                          .toUpperCase(), // WeekDay
                  style: dayTextStyle)
            ],
          ),
        ),
      ),
      onTap: () {
        onDateSelected?.call(this.date);
      },
    );
  }
}
