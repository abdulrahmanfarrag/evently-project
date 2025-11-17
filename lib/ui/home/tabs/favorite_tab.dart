import 'package:flutter/material.dart';
import '../../../data/firebase/event_data_base.dart';
import '../../../data/firebase/firebase_auth_service.dart';
import 'home/widgets/event_card.dart';

class FavoriteTab extends StatelessWidget {
  FavoriteTab({super.key});

  EventsDataBase database = EventsDataBase();

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuthService.getUserData()?.uid ?? "";

    return SafeArea(
      child: Column(
        children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
        hintText: "Search",
        ),),
      ),
          Expanded(
            child: StreamBuilder(
              stream: EventsDataBase.getUserFavoritesStream(userId),
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
      ),
    );
  }
}