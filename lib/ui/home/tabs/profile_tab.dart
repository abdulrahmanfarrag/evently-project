
import 'package:evently_c16_sun/core/providers/app_config_provider.dart';
import 'package:evently_c16_sun/core/theme/app_colors.dart';
import 'package:evently_c16_sun/l10n/translations/app_localizations.dart';
import 'package:evently_c16_sun/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase_auth_service/fire_base_auth_service.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: SizedBox(
                            width: 70,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                "assets/images/Logo.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FirebaseAuthService()
                                    .getUserData()
                                    ?.displayName ??
                                    "",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(color: AppColors.lightBlue),
                              ),
                              Text(
                                FirebaseAuthService().getUserData()?.email ??
                                    "",
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(color: AppColors.lightBlue),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(AppLocalizations.of(context)!.theme),
                ),
                SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton<ThemeMode>(
                    value: provider.themeMode,
                    isExpanded: true,
                    underline: SizedBox(),
                    items:
                    [ThemeMode.dark, ThemeMode.light].map((e) {
                      return DropdownMenuItem<ThemeMode>(
                        value: e,
                        child: Text(e.toString()),
                      );
                    }).toList(),
                    onChanged: (e) {
                      provider.changeTheme(e ?? ThemeMode.dark);
                    },
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(AppLocalizations.of(context)!.language),
                ),
                SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton<String>(
                    value: provider.locale,
                    isExpanded: true,
                    underline: SizedBox(),
                    items:
                    ["en", "ar"].map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (e) {
                      provider.changeLocale(e ?? "en");
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FilledButton(
              onPressed: () async {
                try {
                  await FirebaseAuthService().logout();
                  Navigator.pushReplacementNamed(
                    context,
                    LoginScreen.routeName,
                  );
                } catch (e) {
                  print(e.toString());
                }
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              child: Row(
                children: [Expanded(child: Text("Logout")), Icon(Icons.logout)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}