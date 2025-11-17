import 'package:evently_c16_sun/data/firebase/event_data_base.dart';
import 'package:evently_c16_sun/data/firebase/firebase_auth_service.dart';
import 'package:evently_c16_sun/ui/home/tabs/home/widgets/event_card.dart';
import 'package:evently_c16_sun/ui/home/tabs/home/widgets/user_data_card.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:evently_c16_sun/data/models/category.dart';




class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Category> categories = [];
  late Category selectedCategory;

  @override
  void initState() {
    super.initState();
    categories.add(
      Category(
        id: -1,
        nameEn: "All",
        nameAr: "الكل",
        imagePath: "",
        iconData: Icons.explore,
      ),
    );
    categories.addAll(Category.categories);
    selectedCategory = categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserDataCard(
          user: FirebaseAuthService.getUserData(),
          selectedCategory: selectedCategory,
          categories: categories,
          changeSelectedCategory: changeSelectedCategory,
        ),
        Expanded(
          child: StreamBuilder(
            stream: EventsDataBase.getEventsStream(selectedCategory.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                var events =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemBuilder:
                      (context, index) => EventCard(event: events[index]),
                  separatorBuilder: (_, index) => SizedBox(height: 16),
                  itemCount: events.length,
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }

  void changeSelectedCategory(int index) {
    selectedCategory = categories[index];
    setState(() {});
  }
}