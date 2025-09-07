import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_c16_sun/core/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  late AppConfigProvider appConfigProvider;

  @override
  Widget build(BuildContext context) {
    appConfigProvider = Provider.of<AppConfigProvider>(context);
    return AnimatedToggleSwitch<ThemeMode>.rolling(
      current: appConfigProvider.themeMode,
      values: [ThemeMode.dark, ThemeMode.light],
      onChanged: (theme){
        appConfigProvider.changeTheme(theme);
      },
      iconBuilder: (value, selected) {
        if (value == ThemeMode.dark) {
          return Icon(Icons.dark_mode);
        } else {
          return Icon(Icons.light_mode);
        }
      },
      styleBuilder:
          (i) => ToggleStyle(
            indicatorColor: Theme.of(context).colorScheme.primary,
          ),
      style: ToggleStyle(borderColor: Theme.of(context).colorScheme.primary),
    );
  }
}
