import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_search/features/search/providers/search_provider_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProviderScreen(),
      builder: (context, child) {
        final provider = context.read<SearchProviderScreen>();

        return Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition:
                  const CameraPosition(target: LatLng(31.75, 35.24), zoom: 7),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                provider.mapController = controller;
                provider.mapController.setMapStyle(provider.mapStyle);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(18))),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon:
                          Icon(Icons.search_rounded, color: Colors.amberAccent),
                      suffixIcon: Icon(Icons.map_outlined)),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
