import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';

class VenueListModel {
  int? id;
  String? name;
  String? address;
  double? longitude;
  double? latitude;
  double? distance;
  List<int>? venueCategories;
  List<int>? venueFacilities;
  String? thumbnailUrl;

  VenueListModel({
    this.id,
    this.name,
    this.address,
    this.longitude,
    this.latitude,
    this.distance,
    this.venueCategories,
    this.venueFacilities,
    this.thumbnailUrl,
  });

  VenueListModel.fromJson(Map<String, dynamic> json) {
    id = DynamicParsing(json['id']).parseInt();
    name = DynamicParsing(json['name']).parseString();
    address = DynamicParsing(json['address']).parseString();
    longitude = DynamicParsing(json['longitude']).parseDouble();
    latitude = DynamicParsing(json['latitude']).parseDouble();
    distance = DynamicParsing(json['distance']).parseDouble();
    venueCategories = DynamicParsing(json['venueCategories']).parseList<int>();
    venueFacilities = DynamicParsing(json['venueFacilities']).parseList<int>();
    thumbnailUrl = DynamicParsing(json['thumbnailUrl']).parseString();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'distance': distance,
      'venueCategories': venueCategories,
      'venueFacilities': venueFacilities,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
