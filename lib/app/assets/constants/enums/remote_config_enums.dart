enum RemoteConfigs {
  forceUpdateVersionName('force_update_version_name'),
  forceUpdateMessage('force_update_message'),
  latestVersionName('latest_version_number'),
  latestVersionUpdateMessage('latest_version_update_message'),
  isUnderMaintenance('is_under_maintenance'),
  urlUpdate('url_update');

  final String value;
  const RemoteConfigs(this.value);
}

enum RemoteConfigResponseType {
  none,
  needForceUpdate,
  hasNewVersion,
  underMaintenance,
}
