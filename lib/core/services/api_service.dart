import 'package:dio/dio.dart';
import 'package:map_search/core/constants/api_routes.dart';
import 'package:map_search/domain/entities/marker_entity.dart';
import 'package:map_search/domain/entities/marker_request_entity.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<(List<MarkerEntity>, bool)> fetchMarkers(String inputString) async {
    List<MarkerEntity> data = [];
    bool isSuccess = false;

    try {
      final response = await _dio.post(
        ApiRoutes.getMarkers,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: MarkerRequestEntity(inputString.trim()), // Request body
      );

      if (response.statusCode == 200) {
        for (var e in (response.data['results'] ?? [])) {
          MarkerEntity item = MarkerEntity.fromJson(e);
          data.add(item);
        }
        isSuccess = true;
        return (data, isSuccess);
      }

      print('Failed to fetch markers: ${response.statusCode}');
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
      }

      print('Error: ${e.message}');
    }
    return (data, isSuccess);
  }
}
