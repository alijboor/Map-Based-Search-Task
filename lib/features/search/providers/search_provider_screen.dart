import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:map_search/core/constants/storage_keys.dart';
import 'package:map_search/core/services/api_service.dart';
import 'package:map_search/domain/entities/marker_entity.dart';
import 'dart:async';

import 'package:map_search/features/search/providers/debouncer.dart';

class SearchProviderScreen with ChangeNotifier {
  String? mapStyle;
  GoogleMapController? mapController;

  List<Marker> markers = [];

  Debouncer _debouncer = Debouncer();

  late Box markerBox;
  final ApiService _apiService = ApiService();
  bool isLoading = false;

  SearchProviderScreen() {
    _initMapStyle();
    _initHiveMarker();
  }

  Future<void> _initMapStyle() async {
    rootBundle.loadString('assets/map_style.json').then((string) {
      mapStyle = string;
    });
  }

  Future<void> _initHiveMarker() async {
    Hive.registerAdapter(MarkerEntityAdapter());

    markerBox = await Hive.openBox<MarkerEntity>(StorageKeys.markers);
  }

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> onSearch(String query) async {
    _debouncer.run(() async {
      markers.clear();

      if (query.isEmpty) {
        notifyListeners();
        return;
      }
      _startLoading();

      (List<MarkerEntity>, bool) data = await _apiService.fetchMarkers(query);

      if (!data.$2) {
        await _searchMarkerFromStorage(query);
        _stopLoading();
        return;
      }
      _generateMarkers(data.$1);
      _stopLoading();
    });
  }

  Future<void> _searchMarkerFromStorage(String query) async {
    List<MarkerEntity> data = markerBox.values.toList() as List<MarkerEntity>;
    await _generateMarkers(data
        .where((e) =>
            (e.name ?? '').contains(query) ||
            (e.description ?? '').contains(query) ||
            (e.category ?? '').contains(query))
        .toList());
  }

  Future<void> _generateMarkers(List<MarkerEntity> list) async {
    if (list.isEmpty) return;
    list.forEach((item) async {
      if (item.latitude == null || item.longitude == null) return;
      // check if item not add previously to marker box
      if (!markerBox.containsKey(item.id)) await markerBox.put(item.id, item);

      markers.add(Marker(
        markerId: MarkerId(item.id.toString()),
        position: LatLng(item.latitude!, item.longitude!),
        infoWindow: InfoWindow(title: 'Rating: ${item.rate ?? 0.0}'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ));
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    markers.clear();
    super.dispose();
  }
}
