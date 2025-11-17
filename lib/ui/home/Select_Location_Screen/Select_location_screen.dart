import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  LatLng? selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("اختر الموقع")),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.0444, 31.2357), // القاهرة
          zoom: 10,
        ),
        onTap: (position) {
          setState(() {
            selectedPosition = position;
          });
        },
        markers: selectedPosition == null
            ? {}
            : {
          Marker(
            markerId: const MarkerId("selected-location"),
            position: selectedPosition!,
          ),
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (selectedPosition != null) {
            Navigator.pop(context, selectedPosition);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("من فضلك اختر موقع أولاً")),
            );
          }
        },
        label: const Text("تأكيد الموقع"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}