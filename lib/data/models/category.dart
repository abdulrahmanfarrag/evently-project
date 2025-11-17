import 'package:flutter/material.dart';

class Category {
  int id;
  String nameEn;
  String nameAr;
  String imagePath;
  IconData iconData;

  Category({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
    required this.iconData,
  });

  static List<Category> categories = [
    Category(
      id: 1,
      nameEn: "Sport",
      nameAr: "رياضة",
      imagePath: "assets/images/club.png",
      iconData: Icons.sports_soccer,
    ),
    Category(
      id: 2,
      nameEn: "Birthday",
      nameAr: "عيد ميلاد",
      imagePath: "assets/images/birthday.png",
      iconData: Icons.cake,
    ),
    Category(
      id: 3,
      nameEn: "Meeting",
      nameAr: "اجتماع",
      imagePath: "assets/images/meeting.png",
      iconData: Icons.people,
    ),
    Category(
      id: 4,
      nameEn: "Gaming",
      nameAr: "ألعاب",
      imagePath: "assets/images/gaming.png",
      iconData: Icons.sports_esports,
    ),
    Category(
      id: 5,
      nameEn: "Eating",
      nameAr: "أكل",
      imagePath: "assets/images/eating.png",
      iconData: Icons.restaurant,
    ),
    Category(
      id: 6,
      nameEn: "Holiday",
      nameAr: "عطلة",
      imagePath: "assets/images/holiday.png",
      iconData: Icons.beach_access,
    ),
    Category(
      id: 7,
      nameEn: "Exhibition",
      nameAr: "معرض",
      imagePath: "assets/images/exhibition.png",
      iconData: Icons.palette,
    ),
    Category(
      id: 8,
      nameEn: "Workshop",
      nameAr: "ورشة عمل",
      imagePath: "assets/images/workshop.png",
      iconData: Icons.build,
    ),
    Category(
      id: 9,
      nameEn: "Book Club",
      nameAr: "نادي الكتاب",
      imagePath: "assets/images/Book Club.png",
      iconData: Icons.menu_book,
    ),
  ];

}