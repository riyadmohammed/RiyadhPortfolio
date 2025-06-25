import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_screens.dart';

class DeeplinkPage extends BaseStatefulPage {
  const DeeplinkPage({super.key, required this.id});

  final int id;

  @override
  State<StatefulWidget> createState() => _DeeplinkPageState();
}

class _DeeplinkPageState extends State<DeeplinkPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Welcome to DeepLink page!'),
          Text('id: ${widget.id}'),
        ]),
      ),
    );
  }
}
