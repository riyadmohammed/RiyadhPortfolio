import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

class VenueListResponseModel {
  int? skip;
  int? take;
  int? totalCount;
  int? pageIndex;
  int? perPage;
  int? totalPages;
  List<VenueListModel>? data;

  VenueListResponseModel({
    this.skip,
    this.take,
    this.totalCount,
    this.pageIndex,
    this.perPage,
    this.totalPages,
    this.data,
  });

  VenueListResponseModel.fromJson(Map<String, dynamic> json) {
    skip = DynamicParsing(json['skip']).parseInt();
    take = DynamicParsing(json['take']).parseInt();
    totalCount = DynamicParsing(json['totalCount']).parseInt();
    pageIndex = DynamicParsing(json['pageIndex']).parseInt();
    perPage = DynamicParsing(json['perPage']).parseInt();
    totalPages = DynamicParsing(json['totalPages']).parseInt();
    if (json['data'] != null) {
      data = (json['data'] as List).map((item) => VenueListModel.fromJson(item)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'skip': skip,
      'take': take,
      'totalCount': totalCount,
      'pageIndex': pageIndex,
      'perPage': perPage,
      'totalPages': totalPages,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}
