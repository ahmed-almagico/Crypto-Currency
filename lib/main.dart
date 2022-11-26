import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:graduation_project/models/language_constant.dart';
import 'package:graduation_project/provider/auth_provider.dart';
import 'package:graduation_project/provider/details_provider.dart';
import 'package:graduation_project/provider/home_provider.dart';
import 'package:graduation_project/provider/photo_provider.dart';
import 'package:graduation_project/provider/prof_provider.dart';
import 'package:graduation_project/provider/search_provider.dart';
import 'package:graduation_project/provider/theme_proider.dart';
import 'package:graduation_project/view/design/control.dart';
import 'package:graduation_project/view/design/details.dart';
import 'package:graduation_project/view/design/home.dart';
import 'package:graduation_project/view/design/login_screen.dart';
import 'package:graduation_project/view/design/profile.dart';

import 'package:graduation_project/view/design/register_screen.dart';
import 'package:graduation_project/view/design/searsh.dart';
import 'package:graduation_project/view/design/splash_screen.dart';
import 'package:graduation_project/view/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => SearchProvider()),
      ChangeNotifierProvider(create: (context) => DetailsProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ChangeNotifierProvider(create: (context) => PhotoProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocal) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocal);
  } 
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void didChangeDependencies(){
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        debugShowCheckedModeBanner: false,
        home: Splash());
  }
}
