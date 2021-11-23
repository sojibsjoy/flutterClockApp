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
    var title = AppLocalizations.of(context)!.title;
    if (title != "Clock") {
      dayOfWeek = getDayOfWeek(dayOfWeek, title);
    }

    // adding localization on month
    var month = formattedDate.substring(8);
    if (title != "Clock") {
      month = getMonth(month, title);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
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

  String getDayOfWeek(String dayOfWeek, String title) {
    if (title == "ঘড়ি") {
      switch (dayOfWeek) {
        case "Sun":
          dayOfWeek = "রবিবার";
          break;
        case "Mon":
          dayOfWeek = "সোমবার";
          break;
        case "Tue":
          dayOfWeek = "মঙ্গলবার";
          break;
        case "Wed":
          dayOfWeek = "বুধবার";
          break;
        case "Thu":
          dayOfWeek = "বৃহস্পতিবার";
          break;
        case "Fri":
          dayOfWeek = "শুক্রবার";
          break;
        case "Sat":
          dayOfWeek = "শনিবার";
          break;
        default:
      }
    } else if (title == "घड़ी") {
      switch (dayOfWeek) {
        case "Sun":
          dayOfWeek = "रविवार";
          break;
        case "Mon":
          dayOfWeek = "सोमवार";
          break;
        case "Tue":
          dayOfWeek = "मंगलवार";
          break;
        case "Wed":
          dayOfWeek = "बुधवार";
          break;
        case "Thu":
          dayOfWeek = "गुरूवार";
          break;
        case "Fri":
          dayOfWeek = "शुक्रवार";
          break;
        case "Sat":
          dayOfWeek = "शनिवार";
          break;
        default:
      }
    }
    return dayOfWeek;
  }

  String getMonth(String month, String title) {
    if (title == "ঘড়ি") {
      switch (month) {
        case "Jan":
          month = "জানুয়ারি";
          break;
        case "Feb":
          month = "ফেব্রুয়ারি";
          break;
        case "Mar":
          month = "মার্চ";
          break;
        case "Apr":
          month = "এপ্রিল";
          break;
        case "May":
          month = "মে";
          break;
        case "Jun":
          month = "জুন";
          break;
        case "Jul":
          month = "জুলাই";
          break;
        case "Aug":
          month = "আগস্ট";
          break;
        case "Sep":
          month = "সেপ্টেম্বর";
          break;
        case "Oct":
          month = "অক্টোবর";
          break;
        case "Nov":
          month = "নভেম্বর";
          break;
        case "Dec":
          month = "ডিসেম্বর";
          break;
        default:
      }
    } else if (title == "घड़ी") {
      switch (month) {
        case "Jan":
          month = "जनवरी";
          break;
        case "Feb":
          month = "फ़रवरी";
          break;
        case "Mar":
          month = "मार्च";
          break;
        case "Apr":
          month = "अप्रैल";
          break;
        case "May":
          month = "मई";
          break;
        case "Jun":
          month = "जून";
          break;
        case "Jul":
          month = "जुलाई";
          break;
        case "Aug":
          month = "अगस्त";
          break;
        case "Sep":
          month = "सितंबर";
          break;
        case "Oct":
          month = "अक्टूबर";
          break;
        case "Nov":
          month = "नवंबर";
          break;
        case "Dec":
          month = "दिसंबर";
          break;
        default:
      }
    }
    return month;
  }
}
