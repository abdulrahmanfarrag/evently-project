import 'package:evently_c16_sun/core/providers/app_config_provider.dart';
import 'package:evently_c16_sun/core/theme/app_colors.dart';
import 'package:evently_c16_sun/ui/home/tabs/favorite_tab.dart';
import 'package:evently_c16_sun/ui/home/tabs/home_tab.dart';
import 'package:evently_c16_sun/ui/home/tabs/map_tab.dart';
import 'package:evently_c16_sun/ui/home/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), FavoriteTab(), ProfileTab()];

  late AppConfigProvider appConfigProvider;

  @override
  Widget build(BuildContext context) {
    appConfigProvider = Provider.of(context);
    return Scaffold(
      body: Column(children: [Expanded(child: tabs[selectedIndex])]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        foregroundColor: AppColors.offWhite,
        backgroundColor:
            appConfigProvider.isDark()
                ? AppColors.darkPurple
                : AppColors.purple,
        shape: CircleBorder(
          side: BorderSide(width: 5, color: AppColors.offWhite),
        ),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 2) {
            return;
          }
          if (index == 3 || index == 4) {
            index--;
          }
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex < 2 ? selectedIndex : selectedIndex + 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home_outline),
            activeIcon: Icon(Iconsax.home_bold),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.location_outline),
            activeIcon: Icon(Iconsax.location_bold),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color:
                  appConfigProvider.isDark()
                      ? AppColors.darkPurple
                      : AppColors.purple,
            ),
            activeIcon: Icon(
              Icons.add,
              color:
                  appConfigProvider.isDark()
                      ? AppColors.darkPurple
                      : AppColors.purple,
            ),

            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart_outline),
            activeIcon: Icon(Iconsax.heart_bold),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user_outline),
            activeIcon: Icon(Iconsax.user_bold),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
