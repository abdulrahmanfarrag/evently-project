import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_c16_sun/core/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {

  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return AnimatedToggleSwitch<String>.rolling(
      current: provider.locale,
      values: ["en", "ar"],
      iconBuilder: (value, selected) {
        if (value == "en") {
          return Image.asset("assets/images/LR.png");
        } else {
          return Image.asset("assets/images/EG.png");
        }
      },
      onChanged: (locale){
        provider.changeLocale(locale);
      },
      styleBuilder:
          (i) => ToggleStyle(
            indicatorColor: Theme.of(context).colorScheme.primary,
          ),
      style: ToggleStyle(borderColor: Theme.of(context).colorScheme.primary),
    );
  }
}
