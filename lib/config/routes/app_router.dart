import 'package:auto_route/auto_route.dart';
import 'package:edufund_test/presentation/home/page/home_page.dart';
import 'package:edufund_test/presentation/search/page/search_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true, path: '/'),
        AutoRoute(page: SearchRoute.page, path: '/search'),
      ];
}
