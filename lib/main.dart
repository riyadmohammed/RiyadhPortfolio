import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/utils/starter_handler.dart';
import 'package:dumbdumb_flutter_app/app/view/app.dart';

Future<void> main() async {
  // An init() Function to perform all required initial configuration before app start running
  await init();

  runApp(const App());
}
