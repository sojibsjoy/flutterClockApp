import 'package:clock_bloc/bloc/locale_bloc.dart';
import 'package:clock_bloc/l10n/l10n.dart';
import 'package:clock_bloc/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _localeBloc = LocaleBloc();
    return StreamBuilder<Locale>(
      stream: _localeBloc.localStream,
      initialData: L10n.all.first,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(
            localeBloc: _localeBloc,
          ),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: snapshot.data,
        );
      },
    );
  }
}
