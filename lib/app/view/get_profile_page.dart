import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_screens.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';

class GetProfilePage extends BaseStatefulPage {
  const GetProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _GetProfilePageState();
}

class _GetProfilePageState extends BaseStatefulState<GetProfilePage> {
  @override
  Widget body() {
    return Builder(builder: (context) {
      final userModel = context.select((LoginViewModel vm) => vm.userModel);
      return Center(
        child: Column(
          children: [
            const Text('Welcome'),
            Text(userModel?.fullName ?? '-'),
          ],
        ),
      );
    });
  }

  @override
  Widget floatingActionButton() {
    return FloatingActionButton(
      // ! Use tryLoad or tryCatch to load data from ViewModel, it will handle the error that are thrown from the ViewModel
      // ! Use tryCatch if you don't want to show the loading indicator
      onPressed: () => tryLoad(context, context.read<LoginViewModel>().getProfile),
      child: const Icon(Icons.person_add),
    );
  }
}
