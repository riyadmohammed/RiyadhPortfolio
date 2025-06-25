import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

class AppViewModel extends BaseViewModel {
  late Locale currentAppLocale = Locale(SharedPreferenceHandler().getLanguageCode());
  StreamSubscription<bool>? _connectionChangeStream;
  StreamSubscription<RemoteConfigResponse>? _remoteConfigChangeStream;
  bool hasInternet = true;
  RemoteConfigResponse? forceUpdateRemoteConfigResponse;
  RemoteConfigResponse? newVersionRemoteConfigResponse;
  bool isUnderMaintenance = false;

  AppViewModel() {
    ConnectionUtil.instance.initialize();
    RemoteConfigHandler.instance.initialize();
    _connectionChangeStream = ConnectionUtil.instance.connectionChange.listen(
      (hasConnection) {
        hasInternet = hasConnection;
        RemoteConfigHandler.instance.initialize();
        notifyListeners();
      },
    );

    _remoteConfigChangeStream = RemoteConfigHandler.instance.remoteConfigsUpdate.listen((remoteConfigResponse) {
      if (remoteConfigResponse.type == RemoteConfigResponseType.underMaintenance) {
        isUnderMaintenance = remoteConfigResponse.isUnderMaintenance ?? false;
      }

      if (remoteConfigResponse.type == RemoteConfigResponseType.needForceUpdate) {
        forceUpdateRemoteConfigResponse = remoteConfigResponse;
      }

      if (remoteConfigResponse.type == RemoteConfigResponseType.hasNewVersion) {
        newVersionRemoteConfigResponse = remoteConfigResponse;
      }

      notifyListeners();
    });

    RemoteConfigHandler.instance.initialize();
  }

  @override
  void dispose() {
    _connectionChangeStream?.cancel();
    _remoteConfigChangeStream?.cancel();
    super.dispose();
  }

  Future<void> checkInternetConnection() async {
    final hasInternet = await ConnectionUtil.instance.hasInternet();
    this.hasInternet = hasInternet;
    notifyListeners();
  }

  Future<void> updateLanguage(Language language) async {
    await AppConfigRepository().updateLanguage(language);
    currentAppLocale = Locale(language.languageCode);
    notifyListeners();
  }
}
