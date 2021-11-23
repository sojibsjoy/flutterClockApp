import 'package:clock_bloc/bloc/locale_bloc.dart';
import 'package:clock_bloc/bloc/test_bloc.dart';
import 'package:clock_bloc/constants/colors.dart';
import 'package:clock_bloc/l10n/l10n.dart';
import 'package:clock_bloc/state_management/database/data.dart';
import 'package:clock_bloc/state_management/models/enums.dart';
import 'package:clock_bloc/state_management/models/menu_info.dart';
import 'package:clock_bloc/ui/pages/alarm_page.dart';
import 'package:clock_bloc/ui/pages/clock_page.dart';
import 'package:clock_bloc/ui/pages/stopwatch_page.dart';
import 'package:clock_bloc/ui/pages/timer_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  LocaleBloc localeBloc;
  HomeScreen({Key? key, required this.localeBloc}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variable to display the initial page
  var menuType = MenuType.clock;

  @override
  Widget build(BuildContext context) {
    final _testMenuBloc = TestMenuBloc();

    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Row(
        children: [
          Column(
            children: [
              Flexible(
                flex: 13,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: menuItems
                      .map((currentMenuInfo) =>
                          buildMenuButton(currentMenuInfo, _testMenuBloc))
                      .toList(),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 100,
                  child: TextButton.icon(
                    onPressed: () {
                      // change language in here
                      var currentLocale = Localizations.localeOf(context);
                      // change language one after another sequentially
                      if (currentLocale == L10n.all.first) {
                        widget.localeBloc.eventSink.add(L10n.all[1]);
                      } else if (currentLocale == L10n.all[1]) {
                        widget.localeBloc.eventSink.add(L10n.all.last);
                      } else {
                        widget.localeBloc.eventSink.add(L10n.all.first);
                      }
                    },
                    icon: Icon(
                      Icons.language,
                      color: CustomColors.primaryTextColor,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                        color: CustomColors.primaryTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          VerticalDivider(
            color: CustomColors.dividerColor,
            width: 1,
          ),
          Expanded(
            child: StreamBuilder(
              stream: _testMenuBloc.menuStream,
              initialData: menuType,
              builder: (
                BuildContext context,
                AsyncSnapshot<MenuType> snapshot,
              ) {
                if (snapshot.data == MenuType.alarm) {
                  return const AlarmPage();
                } else if (snapshot.data == MenuType.clock) {
                  return const ClockPage();
                } else if (snapshot.data == MenuType.timer) {
                  return const TimerPage();
                } else {
                  return const StopwatchPage();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo, TestMenuBloc _testMenuBloc) {
    var menuTitle = currentMenuInfo.title;
    var title = AppLocalizations.of(context)!.title;
    menuTitle = getMenuTitle(menuTitle, title);
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
            ),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 0,
          ),
        ),
        backgroundColor: menuType == currentMenuInfo.menuType
            ? MaterialStateProperty.all(CustomColors.menuBackgroundColor)
            : MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        if (currentMenuInfo.menuType == MenuType.alarm) {
          menuType = MenuType.alarm;
          _testMenuBloc.eventSink.add(MenuType.alarm);
        } else if (currentMenuInfo.menuType == MenuType.clock) {
          menuType = MenuType.clock;
          _testMenuBloc.eventSink.add(MenuType.clock);
        } else if (currentMenuInfo.menuType == MenuType.timer) {
          menuType = MenuType.timer;
          _testMenuBloc.eventSink.add(MenuType.timer);
        } else if (currentMenuInfo.menuType == MenuType.stopwatch) {
          menuType = MenuType.stopwatch;
          _testMenuBloc.eventSink.add(MenuType.stopwatch);
        }
        setState(() {});
      },
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Image.asset(
              currentMenuInfo.imageSource,
              height: 54,
              width: 84,
              scale: 1.4,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              menuTitle,
              style: TextStyle(
                fontFamily: 'avenir',
                color: CustomColors.primaryTextColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMenuTitle(String menuTitle, String title) {
    if (title == "ঘড়ি") {
      switch (menuTitle) {
        case "Clock":
          menuTitle = "ঘড়ি";
          break;
        case "Alarm":
          menuTitle = "এলার্ম";
          break;
        case "Timer":
          menuTitle = "টাইমার";
          break;
        case "Stopwatch":
          menuTitle = "স্টপওয়াচ";
          break;
        default:
      }
    } else if (title == "घड़ी") {
      switch (menuTitle) {
        case "Clock":
          menuTitle = "घड़ी";
          break;
        case "Alarm":
          menuTitle = "अलार्म";
          break;
        case "Timer":
          menuTitle = "ठीक घड़ी";
          break;
        case "Stopwatch":
          menuTitle = "स्टॉपवॉच";
          break;
        default:
      }
    }
    return menuTitle;
  }
}
