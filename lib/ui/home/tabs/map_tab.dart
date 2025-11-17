import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(30.045526, 31.238026,),
    zoom: 10,


    )

    );
  }
}
