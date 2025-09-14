import 'package:evently_c16_sun/core/providers/app_config_provider.dart';
import 'package:evently_c16_sun/core/theme/app_theme.dart';
import 'package:evently_c16_sun/l10n/translations/app_localizations.dart';
import 'package:evently_c16_sun/ui/auth/login_screen.dart';
import 'package:evently_c16_sun/ui/auth/register_screen.dart';
import 'package:evently_c16_sun/ui/home/home_screen.dart';
import 'package:evently_c16_sun/ui/setup_screen/setup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var user = FirebaseAuth.instance.currentUser;
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
      child: MyApp(loggedIn: user != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  bool loggedIn;

  MyApp({required this.loggedIn, super.key});

  late AppConfigProvider appConfigProvider;

  @override
  Widget build(BuildContext context) {
    appConfigProvider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: Locale(appConfigProvider.locale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: appConfigProvider.themeMode,
      routes: {
        SetupScreen.routeName: (_) => SetupScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      initialRoute: loggedIn ? HomeScreen.routeName : SetupScreen.routeName,
    );
  }
}
