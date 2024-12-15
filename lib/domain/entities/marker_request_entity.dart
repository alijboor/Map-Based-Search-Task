class MarkerRequestEntity {
  String value;

  MarkerRequestEntity(this.value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inputString'] = value;
    return data;
  }
}
