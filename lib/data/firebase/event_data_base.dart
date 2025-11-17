import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16_sun/data/models/event.dart';

class EventsDataBase {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static CollectionReference<Event> getCollectionReference() {
    return db
        .collection("events")
        .withConverter<Event>(
      fromFirestore:
          (data, snapshot) => Event.fromFirebase(data.data() ?? {}),
      toFirestore: (data, _) => data.toFirebase(),
    );
  }

  static Future<void> createEvent(Event event) async {
    var ref = getCollectionReference();
    var doc = ref.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  static Future<QuerySnapshot<Event>> getEvents() async {
    var ref = getCollectionReference();
    return ref.get();
  }

  static Stream<QuerySnapshot<Event>> getEventsStream(int categoryId) {
    var ref = getCollectionReference();
    if(categoryId == -1){
      return ref.snapshots();
    }
    return ref.where("categoryId", isEqualTo: categoryId).snapshots();
  }

  static Future<void> updateFavoriteState(Event event, String userId) async {
    var doc = getCollectionReference().doc(event.id);

    if (event.favoriteList.contains(userId)) {
      await doc.update({
        'favoriteList': FieldValue.arrayRemove([userId])
      });
    } else {
      await doc.update({
        'favoriteList': FieldValue.arrayUnion([userId])
      });
    }
  }
  static Stream<QuerySnapshot<Event>> getUserFavoritesStream(String userId) {
    var ref = getCollectionReference();
    return ref.where("favoriteList", arrayContains: userId).snapshots();
  }
  static Stream<QuerySnapshot<Event>> getFavoriteStream(String userId) {
    if (userId.isEmpty) {
      return const Stream.empty();
    }

    return db
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .withConverter<Event>(
      fromFirestore: (snapshot, _) => Event.fromFirebase(snapshot.data() ?? {}),
      toFirestore: (event, _) => event.toFirebase(),
    )
        .snapshots();
  }
}