import 'package:hive_flutter/hive_flutter.dart';
import 'package:map_search/core/constants/storage_keys.dart';
import 'package:map_search/domain/entities/marker_entity.dart';

class MarkerLocalManager {
  late Box<MarkerEntity> _markerBox;

  final Map<int, MarkerEntity> _memoryCache = {};

  Future<void> initCache() async {
    Hive.registerAdapter(MarkerEntityAdapter());
    _markerBox = await Hive.openBox<MarkerEntity>(StorageKeys.markers);

    // Populate memory cache from Hive
    for (var marker in _markerBox.values) {
      if (marker.id == null) return;
      _memoryCache[marker.id!] = marker;
    }
  }

  /// Search for markers in the cache by query
  List<MarkerEntity> searchMarkers(String query) {
    return getAllCachedMarkers()
        .where((e) =>
            (e.name ?? '').contains(query) ||
            (e.description ?? '').contains(query) ||
            (e.category ?? '').contains(query))
        .toList();
  }

  /// Update cache with new data from the API
  Future<void> updateCache(List<MarkerEntity> freshData) async {
    for (var item in freshData) {
      if (!_memoryCache.containsKey(item.id)) {
        if (item.id == null) return;

        _memoryCache[item.id!] = item;
        await _markerBox.put(item.id, item); // Save to Hive
      }
    }
  }

  /// Retrieve all cached markers (optional utility method)
  List<MarkerEntity> getAllCachedMarkers() {
    return _memoryCache.isEmpty
        ? _markerBox.values.toList()
        : _memoryCache.values.toList();
  }
}
