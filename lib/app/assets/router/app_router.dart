import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_screens.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_routing.dart';

class AppRouter {
  static String home = '/home';
  static String login = '/';
  static String deeplinkPage = '/deeplink/:deeplinkId';

  /// TODO: This is a dummy setup. Remove this route in the actual project.

  static String paginatedListPage = '/paginatedListPage';
}

class RouterName {
  /// TODO: This is a dummy setup. Remove this route in the actual project.

  static String paginatedListPage = 'paginatedListPage';
}

// TODO: Setup your preferred routing library here
final GoRouter router = GoRouter(routes: [
  GoRoute(path: AppRouter.login, builder: (context, state) => const LoginPage()),
  GoRoute(path: AppRouter.home, builder: (context, state) => const GetProfilePage()),

  /// TODO: This is a dummy setup. Remove this route in the actual project.
  GoRoute(
      path: AppRouter.paginatedListPage,
      name: RouterName.paginatedListPage,
      builder: (context, state) => const PaginatedListPage()),
  GoRoute(
      path: AppRouter.deeplinkPage,
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['deeplinkId'] ?? '') ?? 0;

        return DeeplinkPage(id: id);
      }),
]);
