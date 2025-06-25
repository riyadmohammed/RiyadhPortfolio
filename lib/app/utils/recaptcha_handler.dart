import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';
import 'package:recaptcha_enterprise_flutter/recaptcha.dart';
import 'package:recaptcha_enterprise_flutter/recaptcha_action.dart';

import 'package:recaptcha_enterprise_flutter/recaptcha_client.dart';

enum RecaptchaActionType {
  requestRegisterOtp('requestRegisterOtp'),
  requestLoginOtp('requestLoginOtp'),
  requestDeleteAccountOtp('requestDeleteAccountOtp'),
  register('register'),
  login('login');

  final String value;
  const RecaptchaActionType(this.value);

  RecaptchaAction get action => RecaptchaAction.custom(value);
}

class RecaptchaHandler {
  static RecaptchaHandler instance = RecaptchaHandler._();

  RecaptchaHandler._();

  RecaptchaClient? _client;

  Future<bool> initClient(String siteKey) async {
    try {
      _client = await Recaptcha.fetchClient(siteKey);
      return true;
    } on PlatformException catch (err) {
      debugPrint('RecaptchaHandler.initClient: $err');
      throw NormalErrorException(err.message ?? S.current.failedToInitializeRecaptcha);
    } catch (err) {
      debugPrint('RecaptchaHandler.initClient: $err');
      throw NormalErrorException(err.toString());
    }
  }

  Future<String> execute(RecaptchaActionType recaptchaActionType) async {
    try {
      return await _client?.execute(recaptchaActionType.action) ?? '';
    } on PlatformException catch (err) {
      debugPrint('RecaptchaHandler.execute: $err');
      throw NormalErrorException(err.message ?? S.current.failedToGetRecaptchaToken);
    } catch (err) {
      debugPrint('RecaptchaHandler.execute: $err');
      throw NormalErrorException(err.toString());
    }
  }
}
