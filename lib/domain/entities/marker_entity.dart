import 'package:hive/hive.dart';

part 'marker_entity.g.dart';

@HiveType(typeId: 1)
class MarkerEntity {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? category;

  @HiveField(3)
  String? description;

  @HiveField(4)
  double? latitude;

  @HiveField(5)
  double? longitude;

  @HiveField(6)
  double? rate;

  MarkerEntity(
      {this.id,
      this.name,
      this.category,
      this.description,
      this.latitude,
      this.longitude,
      this.rate});

  factory MarkerEntity.fromJson(Map<String, dynamic> json) {
    return MarkerEntity(
      id: json['id'],
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['descreption'] ?? '',
      latitude: json['latitude'] != null ? json['latitude'] as double : null,
      longitude: json['longitude'] != null ? json['longitude'] as double : null,
      rate: json['rate'] != null ? json['rate'] as double : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['rate'] = rate;
    return data;
  }
}
