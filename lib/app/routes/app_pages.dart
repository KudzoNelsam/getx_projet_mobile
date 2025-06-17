import 'package:get/get.dart';

import '../modules/clients/form/bindings/clients_form_binding.dart';
import '../modules/clients/form/views/clients_form_view.dart';
import '../modules/clients/list/bindings/clients_list_binding.dart';
import '../modules/clients/list/views/clients_list_view.dart';
import '../modules/dettes/detail/bindings/dettes_detail_binding.dart';
import '../modules/dettes/detail/views/dettes_detail_view.dart';
import '../modules/dettes/form/bindings/dettes_form_binding.dart';
import '../modules/dettes/form/views/dettes_form_view.dart';
import '../modules/dettes/list/bindings/dettes_list_binding.dart';
import '../modules/dettes/list/views/dettes_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CLIENTS_LIST;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CLIENTS_FORM,
      page: () => const ClientsFormView(),
      binding: ClientsFormBinding(),
    ),
    GetPage(
      name: _Paths.CLIENTS_LIST,
      page: () => const ClientsListView(),
      binding: ClientsListBinding(),
    ),
    GetPage(
      name: _Paths.DETTES_LIST,
      page: () => const DettesListView(),
      binding: DettesListBinding(),
    ),
    GetPage(
      name: _Paths.DETTES_FORM,
      page: () => const DettesFormView(),
      binding: DettesFormBinding(),
    ),
    GetPage(
      name: _Paths.DETTES_DETAIL,
      page: () => const DettesDetailView(),
      binding: DettesDetailBinding(),
    ),
  ];
}
