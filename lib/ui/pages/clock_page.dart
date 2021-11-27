import 'package:clock_bloc/constants/colors.dart';
import 'package:clock_bloc/ui/design/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, dd MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) {
      offsetSign = '+';
    }
    // adding localization on day of the week
    var dayOfWeek = formattedDate.substring(0, 3);
    var title = AppLocalizations.of(context)!.clock_title;
    if (title != "Clock") {
      dayOfWeek = getDayOfWeek(context, dayOfWeek);
    }

    // adding localization on month
    var month = formattedDate.substring(8);
    if (title != "Clock") {
      month = getMonth(context, month);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
      alignment: Alignment.center,
      color: CustomColors.pageBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              // title of the Clock Screen
              title,
              style: const TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Displaying Time
                  formattedTime,
                  style: const TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 64,
                  ),
                ),
                Text(
                  // Displaying Date
                  dayOfWeek + formattedDate.substring(3, 8) + month,
                  style: const TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.center,
              child: ClockView(
                size: MediaQuery.of(context).size.height / 3.5,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Time Zone Text
                  AppLocalizations.of(context)!.timezone,
                  style: const TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'UTC' + offsetSign + timezoneString,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getDayOfWeek(BuildContext context, String dayOfWeek) {
    switch (dayOfWeek) {
      case "Sun":
        dayOfWeek = AppLocalizations.of(context)!.sun;
        break;
      case "Mon":
        dayOfWeek = AppLocalizations.of(context)!.mon;
        break;
      case "Tue":
        dayOfWeek = AppLocalizations.of(context)!.tue;
        break;
      case "Wed":
        dayOfWeek = AppLocalizations.of(context)!.wed;
        break;
      case "Thu":
        dayOfWeek = AppLocalizations.of(context)!.thu;
        break;
      case "Fri":
        dayOfWeek = AppLocalizations.of(context)!.fri;
        break;
      case "Sat":
        dayOfWeek = AppLocalizations.of(context)!.sat;
        break;
      default:
    }
    return dayOfWeek;
  }

  String getMonth(BuildContext context, String month) {
    switch (month) {
      case "Jan":
        month = AppLocalizations.of(context)!.jan;
        break;
      case "Feb":
        month = AppLocalizations.of(context)!.feb;
        break;
      case "Mar":
        month = AppLocalizations.of(context)!.mar;
        break;
      case "Apr":
        month = AppLocalizations.of(context)!.apr;
        break;
      case "May":
        month = AppLocalizations.of(context)!.may;
        break;
      case "Jun":
        month = AppLocalizations.of(context)!.jun;
        break;
      case "Jul":
        month = AppLocalizations.of(context)!.jul;
        break;
      case "Aug":
        month = AppLocalizations.of(context)!.aug;
        break;
      case "Sep":
        month = AppLocalizations.of(context)!.sep;
        break;
      case "Oct":
        month = AppLocalizations.of(context)!.oct;
        break;
      case "Nov":
        month = AppLocalizations.of(context)!.nov;
        break;
      case "Dec":
        month = AppLocalizations.of(context)!.dec;
        break;
      default:
    }
    return month;
  }
}
