import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:map_search/core/constants/storage_keys.dart';
import 'package:map_search/core/services/api_service.dart';
import 'package:map_search/domain/entities/marker_entity.dart';
import 'package:map_search/features/search/providers/cache_aside_manager.dart';
import 'dart:async';

import 'package:map_search/features/search/providers/debouncer.dart';
import 'package:map_search/features/search/providers/marker_cashe_manager.dart';

class SearchProviderScreen with ChangeNotifier {
  String? mapStyle;
  GoogleMapController? mapController;

  List<Marker> markers = [];

  final Debouncer _debouncer = Debouncer();

  final ApiService _apiService = ApiService();
  final MarkerLocalManager _cacheManager = MarkerLocalManager();

  late CacheAsideManager<MarkerEntity> _cacheAsidePattern;

  bool isLoading = false;

  SearchProviderScreen() {
    _initMapStyle();
    _initCache();
  }

  Future<void> _initMapStyle() async {
    rootBundle.loadString('assets/map_style.json').then((string) {
      mapStyle = string;
    });
  }

  Future<void> _initCache() async {
    await _cacheManager.initCache();

    _cacheAsidePattern = CacheAsideManager<MarkerEntity>(
      fetchFromApi: _apiFetchMarkers,
      fetchFromCache: _cacheManager.searchMarkers,
      updateCache: _cacheManager.updateCache,
    );
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

      // Use the Cache-Aside Pattern to get data
      final List<MarkerEntity> markerList =
          await _cacheAsidePattern.getData(query);

      _generateMarkers(markerList);
      _stopLoading();
    });
  }

  /// Fetch markers from the API
  Future<List<MarkerEntity>> _apiFetchMarkers(String query) async {
    (List<MarkerEntity>, bool) apiResult =
        await _apiService.fetchMarkers(query);
    return apiResult.$2 ? apiResult.$1 : [];
  }

  Future<void> _generateMarkers(List<MarkerEntity> list) async {
    if (list.isEmpty) return;
    list.forEach((item) async {
      if (item.latitude == null || item.longitude == null) return;
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
