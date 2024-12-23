class CacheAsideManager<T> {
  final Future<List<T>> Function(String query) fetchFromApi;
  final List<T> Function(String query) fetchFromCache;
  final Future<void> Function(List<T> data) updateCache;

  CacheAsideManager({
    required this.fetchFromApi,
    required this.fetchFromCache,
    required this.updateCache,
  });

  /// Execute the cache-aside logic
  Future<List<T>> getData(String query) async {
    // First fetch from API
    final apiData = await fetchFromApi(query);

    if (apiData.isNotEmpty) {
      // Update cache with fresh data
      await updateCache(apiData);
      return apiData;
    }

    final cachedData = fetchFromCache(query);
    return cachedData;
  }
}
