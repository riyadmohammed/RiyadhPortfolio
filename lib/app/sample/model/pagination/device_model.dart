import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';

class DeviceModel {
  String? deviceNo;
  int? deviceType;
  String? registrationId;
  String? guiVersion;
  bool? isIosSandBox;

  DeviceModel(this.deviceNo, this.deviceType, this.registrationId, this.guiVersion, this.isIosSandBox);

  DeviceModel.fromJson(Map<String, dynamic> json) {
    deviceNo = DynamicParsing(json['deviceNo']).parseString();
    deviceType = DynamicParsing(json['deviceType']).parseInt();
    registrationId = DynamicParsing(json['registrationId']).parseString();
    guiVersion = DynamicParsing(json['guiVersion']).parseString();
    isIosSandBox = DynamicParsing(json['isIosSandBox']).parseBool();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'deviceNo': deviceNo,
      'deviceType': deviceType,
      'registrationId': registrationId,
      'guiVersion': guiVersion,
      'isIosSandBox': isIosSandBox
    };
  }
}
