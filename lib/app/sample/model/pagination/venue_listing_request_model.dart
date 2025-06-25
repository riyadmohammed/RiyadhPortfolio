import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';

class VenueListingRequestModel {
  String? filterBy;
  String? filterString;
  String? orderBy;
  String? startDate;
  String? endDate;
  double? latitude;
  double? longitude;
  List<int>? venueFacilities;
  List<int>? venueCategories;
  int? skip;
  int? take;
  bool? isOrderByDesc;

  VenueListingRequestModel({
    this.filterBy,
    this.filterString,
    this.orderBy,
    this.startDate,
    this.endDate,
    this.latitude,
    this.longitude,
    this.venueFacilities,
    this.venueCategories,
    this.skip,
    this.take,
    this.isOrderByDesc,
  });

  VenueListingRequestModel.fromJson(Map<String, dynamic> json) {
    filterBy = DynamicParsing(json['filterBy']).parseString();
    filterString = DynamicParsing(json['filterString']).parseString();
    orderBy = DynamicParsing(json['orderBy']).parseString();
    startDate = DynamicParsing(json['startDate']).parseString();
    endDate = DynamicParsing(json['endDate']).parseString();
    latitude = DynamicParsing(json['latitude']).parseDouble();
    longitude = DynamicParsing(json['longitude']).parseDouble();
    venueFacilities = DynamicParsing(json['venueFacilities']).parseList<int>();
    venueCategories = DynamicParsing(json['venueCategories']).parseList<int>();

    skip = DynamicParsing(json['skip']).parseInt();
    take = DynamicParsing(json['take']).parseInt();
    isOrderByDesc = DynamicParsing(json['isOrderByDesc']).parseBool();
  }

  Map<String, dynamic> toJson() {
    return {
      if (filterBy != null) 'filterBy': filterBy,
      if (filterString != null) 'filterString': filterString,
      if (orderBy != null) 'orderBy': orderBy,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (venueFacilities != null) 'venueFacilities': venueFacilities,
      if (venueCategories != null) 'venueCategories': venueCategories,
      if (skip != null) 'skip': skip,
      if (take != null) 'take': take,
      if (isOrderByDesc != null) 'isOrderByDesc': isOrderByDesc,
    };
  }
}
