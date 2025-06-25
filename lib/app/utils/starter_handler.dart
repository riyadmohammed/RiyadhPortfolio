import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';
import 'package:dumbdumb_flutter_app/app/assets/firebase_options/production_firebase_options.dart' as production;
import 'package:dumbdumb_flutter_app/app/assets/firebase_options/staging_firebase_options.dart' as staging;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

/// Function to perform all initial configuration based on running environment
/// Any method, feature that requires to init()/start() before app running, may do it here
Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHandler().initialize();

  // TODO: Regenate the FirebaseOptions for your project using FlutterFire CLI
  switch (appEnvironmentType) {
    case EnvironmentType.staging:
      await Firebase.initializeApp(
        options: staging.DefaultFirebaseOptions.currentPlatform,
      );
    case EnvironmentType.production:
      await Firebase.initializeApp(
        options: production.DefaultFirebaseOptions.currentPlatform,
      );
  }

  try {
    await RecaptchaHandler.instance.initClient(EnvValues.recaptchaSiteKey);
  } on NormalErrorException catch (e) {
    debugPrint('Recaptcha Init Error: ${e.message}');
  }

  // Pass all uncaught errors from the framework to Crashlytics.
  if (!kDebugMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }

  if (SharedPreferenceHandler().getLanguageCode().isEmpty) {
    final systemLanguage = Platform.localeName;
    var appLanguage = Language.english;

    if (systemLanguage.contains(Language.english.languageCode)) {
      appLanguage = Language.english;
    } else if (systemLanguage.contains(Language.bm.languageCode)) {
      appLanguage = Language.bm;
    }

    await SharedPreferenceHandler().putLanguageCode(appLanguage.languageCode);
  }

  // App root detection
  // Platform messages may fail, so we use a try/catch PlatformException.
  bool jailBroken = await _checkIsJailBroken();
  bool developerMode = false;
  try {
    developerMode = await JailbreakRootDetection.instance.isDevMode;
  } catch (e) {
    developerMode = true;
  }

  await SharedPreferenceHandler().putRootDetectionDeveloperMode(developerMode);
  await SharedPreferenceHandler().putRootDetectionJailBroken(jailBroken);
}

/// Checks if the device is jailbroken or rooted.
///
/// This function uses the `JailbreakRootDetection` plugin to determine if the device is compromised.
/// It returns `true` if the device is detected as jailbroken/rooted or if an exception occurs during the check.
/// In debug mode, it always returns `false` for testing purposes.
Future<bool> _checkIsJailBroken() async {
  if (kDebugMode) return false;

  try {
    // Check if the device is reported as jailbroken/rooted
    final jailBroken = await JailbreakRootDetection.instance.isJailBroken;

    if (jailBroken) {
      // Retrieve the list of specific jailbreak/root issues detected
      final issues = await JailbreakRootDetection.instance.checkForIssues;

      // Confirm jailbreak/root status based on critical issues found
      if (issues.contains(JailbreakIssue.cydiaFound) ||
          issues.contains(JailbreakIssue.reverseEngineered) ||
          issues.contains(JailbreakIssue.fridaFound) ||
          issues.contains(JailbreakIssue.tampered) ||
          issues.contains(JailbreakIssue.jailbreak)) {
        return true;
      } else {
        // No critical issues found, consider the device as not jailbroken/rooted
        return false;
      }
    } else {
      // Device is not reported as jailbroken/rooted
      return false;
    }
  } catch (e) {
    // If an error occurs, assume the device is jailbroken/rooted to maintain security
    return true;
  }
}
