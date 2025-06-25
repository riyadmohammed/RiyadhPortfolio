import 'package:collection/collection.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

class RemoteConfigResponse {
  RemoteConfigResponse({
    required this.type,
    this.message,
    this.updateUrl,
    this.isUnderMaintenance,
  });

  final RemoteConfigResponseType type;
  final String? message;
  final String? updateUrl;
  final bool? isUnderMaintenance;
}

class RemoteConfigHandler {
  FirebaseRemoteConfig get _rc => FirebaseRemoteConfig.instance;

  final StreamController<RemoteConfigResponse> _remoteConfigStreamController = StreamController();
  Stream<RemoteConfigResponse> get remoteConfigsUpdate => _remoteConfigStreamController.stream.asBroadcastStream();

  final currentVersionName = PackageInfo.fromPlatform().then(
    (value) => value.version,
  );

  RemoteConfigHandler._privateConstructor() {
    _rc.onConfigUpdated.listen((event) async {
      await _rc.fetchAndActivate();
      final keys = event.updatedKeys;

      final currentVersion = Version.parse(await currentVersionName);

      if (keys.contains(RemoteConfigs.isUnderMaintenance.value)) {
        sendUnderMaintenanceStream();
      }

      if (keys.contains(RemoteConfigs.forceUpdateVersionName.value) &&
          checkIfNeedForceUpdate(currentVersion: currentVersion)) {
        sendForceUpdateStream();

        return;
      }

      if (keys.contains(RemoteConfigs.latestVersionName.value) &&
          checkIfHasNewVersion(currentVersion: currentVersion)) {
        sendHasNewVersionStream();
      }
    });
  }

  static final RemoteConfigHandler _instance = RemoteConfigHandler._privateConstructor();
  static RemoteConfigHandler get instance => _instance;

  Future<void> initialize() async {
    await _rc.setDefaults(<String, dynamic>{
      RemoteConfigs.forceUpdateVersionName.value: await currentVersionName,
      RemoteConfigs.forceUpdateMessage.value: '',
      RemoteConfigs.latestVersionName.value: await currentVersionName,
      RemoteConfigs.latestVersionUpdateMessage.value: '',
      RemoteConfigs.urlUpdate.value: '',
      RemoteConfigs.isUnderMaintenance.value: false,
    });

    await _rc.fetchAndActivate();

    await checkRemoteConfig();
  }
}

// * ------------------------ Helpers ------------------------
extension _Helpers on RemoteConfigHandler {
  bool checkIfUnderMaintenance() {
    return _rc.getBool(RemoteConfigs.isUnderMaintenance.value);
  }

  bool checkIfNeedForceUpdate({
    required Version currentVersion,
  }) {
    final forceUpdateVersion = Version.parse(
      _rc.getString(RemoteConfigs.forceUpdateVersionName.value),
    );

    return currentVersion < forceUpdateVersion;
  }

  bool checkIfHasNewVersion({
    required Version currentVersion,
  }) {
    final latestVersion = Version.parse(
      _rc.getString(RemoteConfigs.latestVersionName.value),
    );

    return currentVersion < latestVersion;
  }

  String? decodeMessage(String configKey) {
    final rawMessage = _rc.getValue(configKey).asString();

    final decodedMessage = json.decode(rawMessage);

    if (decodedMessage is List) {
      final messageList = decodedMessage.map((x) => RemoteConfigResponseModel.fromJson(x)).toList();
      return messageList
          .firstWhereOrNull((element) => element.lang == SharedPreferenceHandler().getLanguageCode())
          ?.message;
    }
    return null;
  }

  Future<void> checkRemoteConfig() async {
    sendUnderMaintenanceStream();

    final currentVersion = Version.parse(await currentVersionName);

    final needForceUpdate = checkIfNeedForceUpdate(
      currentVersion: currentVersion,
    );

    if (needForceUpdate) {
      sendForceUpdateStream();
      return;
    }

    final hasNewVersion = checkIfHasNewVersion(
      currentVersion: currentVersion,
    );

    if (hasNewVersion) {
      sendHasNewVersionStream();
    }
  }

  void sendUnderMaintenanceStream() {
    final isUnderMaintenance = checkIfUnderMaintenance();

    _remoteConfigStreamController.add(
      RemoteConfigResponse(
        type: RemoteConfigResponseType.underMaintenance,
        isUnderMaintenance: isUnderMaintenance,
      ),
    );
  }

  void sendForceUpdateStream() {
    final updateUrl = _rc.getString(RemoteConfigs.urlUpdate.value);
    final message = decodeMessage(RemoteConfigs.forceUpdateMessage.value) ??
        S.current.remoteConfigForceUpdateMessage(appEnvironmentType.appName);
    _remoteConfigStreamController.add(
      RemoteConfigResponse(
        type: RemoteConfigResponseType.needForceUpdate,
        message: message,
        updateUrl: updateUrl,
      ),
    );
  }

  void sendHasNewVersionStream() {
    final updateUrl = _rc.getString(RemoteConfigs.urlUpdate.value);
    final message = decodeMessage(RemoteConfigs.latestVersionUpdateMessage.value) ??
        S.current.remoteConfigLatestUpdateMessage(appEnvironmentType.appName);
    _remoteConfigStreamController.add(
      RemoteConfigResponse(
        type: RemoteConfigResponseType.hasNewVersion,
        message: message,
        updateUrl: updateUrl,
      ),
    );
  }
}
