import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

class PaginationRepository {
  final PaginationServices _paginationServices = PaginationServices();

  Future<MyResponse> guestLogin(DeviceModel model) async {
    final response = await _paginationServices.guestLogin(model);

    if (response.data is Map<String, dynamic>) {
      final responseModel = ResponseModel.fromJson(response.data as Map<String, dynamic>);

      if (responseModel.result is Map<String, dynamic>) {
        final user = GuestLoginResponseModel.fromJson(responseModel.result);
        return MyResponse.complete(user);
      }
    }
    return response;
  }

  Future<MyResponse> getVenueList(VenueListingRequestModel model) async {
    /// This is just a sample to simulate a delay and return a list of venues.
    await Future.delayed(Duration(milliseconds: 500));

    final random = Random();
    final venues = List.generate(20, (index) {
      final id = random.nextInt(1000000);
      final name = 'Venue_${random.nextInt(9999)}';
      return VenueListModel(id: id, name: name);
    });

    /// For demo purpose, I will return a list of VenueListModel with dummy data.
    return MyResponse.complete(venues);
  }
}
