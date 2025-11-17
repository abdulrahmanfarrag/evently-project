import 'package:evently_c16_sun/data/firebase/event_data_base.dart';
import 'package:evently_c16_sun/data/firebase/firebase_auth_service.dart';
import 'package:evently_c16_sun/data/models/category.dart';
import 'package:evently_c16_sun/data/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../event_details_screen/event_details screen.dart';


class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    var category = Category.categories.firstWhere(
          (e) => e.id == (event.categoryId ?? -1),
    );
    var userId = FirebaseAuthService
        .getUserData()
        ?.uid ?? "";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 360 / 200,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(category.imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 2,
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ) ,
                child: Text(DateFormat('dd\nMMM').format(DateTime.fromMillisecondsSinceEpoch(event.date??0)), textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelMedium
                  ,),

              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .surface
                      .withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        event.title ?? "",
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        EventsDataBase.updateFavoriteState(event, userId);
                      },
                      icon: Icon(
                        (event.favoriteList ?? []).contains(userId)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}