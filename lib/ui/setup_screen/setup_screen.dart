import 'package:evently_c16_sun/core/widgets/language_switch.dart';
import 'package:evently_c16_sun/core/widgets/theme_switch.dart';
import 'package:evently_c16_sun/l10n/translations/app_localizations.dart';
import 'package:evently_c16_sun/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SetupScreen extends StatelessWidget {
  static const String routeName = "/setupScreen";

  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/horizontal_logo.png", height: 80),
                ],
              ),
              Expanded(child: Image.asset("assets/images/config_screen_1.png")),
              SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.personalizeYourExperience,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.personalizeYourExperienceMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                  LanguageSwitch(),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                  ThemeSwitch(),
                ],
              ),
              SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(AppLocalizations.of(context)!.letsGo)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
