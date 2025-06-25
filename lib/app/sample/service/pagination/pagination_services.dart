import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

class PaginationServices extends BaseServices {
  Future<MyResponse> venueList(VenueListingRequestModel model, String accessToken) async {
    String path = 'https://l5a5iu29mh.execute-api.ap-southeast-1.amazonaws.com/staging/api/v1/venues';
    return callAPI(HttpRequestType.get, path,
        queryParameters: model.toJson(), options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
  }

  Future<MyResponse> guestLogin(DeviceModel model) async {
    String path = 'https://l5a5iu29mh.execute-api.ap-southeast-1.amazonaws.com/staging/api/v1/users/guest-mode';
    return callAPI(HttpRequestType.post, path, postBody: model.toJson(), noAuth: true);
  }
}
