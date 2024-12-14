import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchProviderScreen with ChangeNotifier {
  late String mapStyle;

  late GoogleMapController mapController;

  SearchProviderScreen() {
    _initMapStyle();
    mapStyle = '';
  }

  Future<void> _initMapStyle() async {
    rootBundle.loadString('assets/map_style.json').then((string) {
      mapStyle = string;
    });
  }
}
