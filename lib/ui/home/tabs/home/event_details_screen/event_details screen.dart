import 'package:evently_c16_sun/data/models/event.dart';
import 'package:evently_c16_sun/data/models/category.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final category = Category.categories.firstWhere(
          (c) => c.id == event.categoryId,
      orElse: () => Category.categories.first,
    );

    String formattedDate = event.date != null
        ? DateFormat("dd/MM/yyyy").format(
      DateTime.fromMillisecondsSinceEpoch(event.date!),
    )
        : "—";

    String formattedTime = event.time != null
        ? DateFormat("hh:mm a").format(
      DateTime.fromMillisecondsSinceEpoch(event.time!),
    )
        : "—";

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title ?? "Event Details"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              category.imagePath,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            event.title ?? "",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined),
              const SizedBox(width: 8),
              Text("Date: $formattedDate"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time_outlined),
              const SizedBox(width: 8),
              Text("Time: $formattedTime"),
            ],
          ),
          const SizedBox(height: 16),
          if (event.latitude != null && event.longitude != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Event Location",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(event.latitude!, event.longitude!),
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("event-location"),
                          position: LatLng(event.latitude!, event.longitude!),
                        ),
                      },
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Description'),
                Text(
                  textAlign: TextAlign.center,
                  event.description ?? "",
                ),
                const SizedBox(height: 16),
              ],
            )
          else
            const Text("No location selected for this event."),
        ],
      ),
    );
  }
}