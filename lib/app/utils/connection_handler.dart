import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionUtil {
  ConnectionUtil._privateConstructor();

  // * Private properties
  static final ConnectionUtil _instance = ConnectionUtil._privateConstructor();
  final StreamController<bool> _connectionChangeController = StreamController();
  late InternetConnection _internetChecker;

  // * Public properties
  static ConnectionUtil get instance => _instance;

  bool get hasConnection => _hasConnection;
  bool _hasConnection = false;
  Stream<bool> get connectionChange => _connectionChangeController.stream;

  // * Public methods
  Future<bool> initialize() async {
    _internetChecker = InternetConnection.createInstance(
      customCheckOptions: [
        InternetCheckOption(uri: Uri.parse('https://www.google.com')),
      ],
    );

    _internetChecker.onStatusChange.listen((status) {
      final previousConnection = hasConnection;

      switch (status) {
        case InternetStatus.connected:
          _hasConnection = true;
        case InternetStatus.disconnected:
          _hasConnection = false;
      }

      if (previousConnection != hasConnection) {
        _connectionChangeController.add(hasConnection);
      }
    });

    _hasConnection = await hasInternet();
    return _hasConnection;
  }

  Future<bool> hasInternet() async {
    return _internetChecker.hasInternetAccess;
  }

  void dispose() {
    _connectionChangeController.close();
  }
}
