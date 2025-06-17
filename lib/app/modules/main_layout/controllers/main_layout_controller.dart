import 'package:default_projec/app/routes/app_pages.dart';
import 'package:default_projec/app/routes/navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayoutController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changePage(int value) {
    currentIndex.value = value;
  }

  final RxList<NavigationItem> navigationItems = [
    NavigationItem(icon: Icons.supervised_user_circle_sharp, label: "Clients", route: Routes.CLIENTS_LIST),
    NavigationItem(
      icon: Icons.account_balance,
      label: "Dettes",
      route: Routes.DETTES_LIST,
    ),
  ].obs;

  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    return navigationItems
        .map(
          (item) =>
              BottomNavigationBarItem(icon: Icon(item.icon), label: item.label),
        )
        .toList();
  }

  int getCurrentIndex() {
    final String route = Get.currentRoute;
    final int index = navigationItems.indexWhere(
      (element) => element.route == route,
    );
    return index >= 0 ? index : 0;
  }

  void navigateTo(int index) {
    Get.offNamed(navigationItems[index].route);
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView.builder(
        itemCount: navigationItems.length,
        itemBuilder: (context, index) {
          final item = navigationItems[index];
          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
            selected: getCurrentIndex() == index,
            onTap: () {
              navigateTo(index);
            },
          );
        },
      ),
    );
  }
}
