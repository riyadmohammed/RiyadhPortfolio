// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(appName) =>
      "${appName} does not have access to your photos. To enable access, tap Settings and turn on Photos.";

  static String m1(appName) =>
      "Please update to latest version of ${appName} to continue access to the app features.";

  static String m2(appName) =>
      "There is a newer version of ${appName}, would you like to update?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "apiRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Oppss.. something went wrong. Please contact admin for assistance.",
    ),
    "bm": MessageLookupByLibrary.simpleMessage("Bahasa Melayu"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "errorTitle": MessageLookupByLibrary.simpleMessage("Error"),
    "failedToGetRecaptchaToken": MessageLookupByLibrary.simpleMessage(
      "Failed to get reCAPTCHA token",
    ),
    "failedToInitializeRecaptcha": MessageLookupByLibrary.simpleMessage(
      "Failed to initialize reCAPTCHA",
    ),
    "jailbrokenWarning": MessageLookupByLibrary.simpleMessage(
      "This device appear to be jailbroken or rooted. There are inherent risks with jailbroken or rooted devices and therefore the further usage of this app is not allowed.",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
    "mandarin": MessageLookupByLibrary.simpleMessage("中文"),
    "noInternetConnectionPlsTryAgain": MessageLookupByLibrary.simpleMessage(
      "No internet connection is available. Please connect to the internet and try again.",
    ),
    "noPhotosPermissionMessage": m0,
    "noVenueFound": MessageLookupByLibrary.simpleMessage("No Venue Found"),
    "permissionNeeded": MessageLookupByLibrary.simpleMessage(
      "Permission Needed",
    ),
    "remoteConfigForceUpdateMessage": m1,
    "remoteConfigLatestUpdateMessage": m2,
    "sessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "Your session has expired. Please login again.",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "textOk": MessageLookupByLibrary.simpleMessage("OK"),
    "underMaintenanceMessage": MessageLookupByLibrary.simpleMessage(
      "Our app is currently undergoing maintenance. We appreciate your patience and will be back shortly.",
    ),
    "underMaintenanceTitle": MessageLookupByLibrary.simpleMessage(
      "We\'ll Be Back Soon!",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updateAvailable": MessageLookupByLibrary.simpleMessage("Update Available"),
    "updateRequired": MessageLookupByLibrary.simpleMessage("Update Required"),
  };
}
