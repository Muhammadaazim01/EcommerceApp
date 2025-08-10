class AddressModel {
  int? id;
  String? name;
  String? description;
  double? latitude;
  double? longitude;

  AddressModel({
    this.id,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    latitude = (json['latitude'] != null) ? json['latitude'].toDouble() : null;
    longitude = (json['longitude'] != null)
        ? json['longitude'].toDouble()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
