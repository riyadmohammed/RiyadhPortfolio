import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

class VenueListingViewModel extends BaseViewModel {
  final _paginationRepo = PaginationRepository();

  final _sharedPreferencesHandler = SharedPreferenceHandler();
  String? get token => _sharedPreferencesHandler.getAccessToken();

  // State to manage the paginated venue list.
  PagingState<int, VenueListModel> venuePagingState = PagingState();

  Future<void> getVenueList(int pageKey) async {
    final queryParams = VenueListingRequestModel(
      skip: pageKey * GeneralConstant.defaultPageTake,
      take: GeneralConstant.defaultPageTake,
    );
    List<VenueListModel>? data;

    // Fetch the venue data using the repository.
    MyResponse response = await _paginationRepo.getVenueList(queryParams);
    if (response.data is List<VenueListModel>) {
      // Cast response data to the expected model.
      data = response.data as List<VenueListModel>;

      // Reset the paging state if it's the first page.
      if (pageKey == GeneralConstant.defaultPageKey) {
        venuePagingState = PagingState(keys: [GeneralConstant.defaultPageKey]);
      }

      final isLastPage = data.length < GeneralConstant.defaultPageTake;

      // Update the paging state with the new data and next page key.
      venuePagingState = PagingState(
        pages: [...?venuePagingState.pages, data],
        keys: [...?venuePagingState.keys, pageKey],
        hasNextPage: !isLastPage,
      );
    }
    checkError(response);
    notifyListeners();
  }

  /// Logs in as a guest user to retrieve a temporary access token.
  Future<void> guestLogin() async {
    // Prepare the request body with dummy device data.
    final postBody = DeviceModel('string', 0, 'string', 'string', true);

    final response = await _paginationRepo.guestLogin(postBody);

    if (response.data is GuestLoginResponseModel) {
      final data = response.data as GuestLoginResponseModel;
      await SharedPreferenceHandler().putAccessToken(data.accessToken);
    }
    checkError(response);
    notifyListeners();
  }
}
