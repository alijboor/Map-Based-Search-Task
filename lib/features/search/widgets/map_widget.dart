import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_search/features/search/providers/search_provider_screen.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProviderScreen>(builder: (context, provider, child) {
      return GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition:
            const CameraPosition(target: LatLng(31.75, 35.24), zoom: 7),
        zoomControlsEnabled: false,
        myLocationButtonEnabled: true,
        markers: provider.markers.toSet(),
        onMapCreated: (controller) {
          provider.mapController = controller;
          provider.mapController?.setMapStyle(provider.mapStyle);
        },
      );
    });
  }
}
