import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/main/routes.dart';
import 'package:flutter_hygrowmon/theme_data/AppColor.dart';

class AppNavbarItem {
  Widget item;
  String route;

  AppNavbarItem({required this.item, required this.route});
}

Widget AppNavbar(
  String selectedRoute,
  Function(String, int) onItemClicked,
) {
  final items = [
    AppNavbarItem(
      item: NavigationDestination(
        icon: ImageIcon(
          AssetImage("assets/images/navbar_dashboard.png"),
          color: Colors.grey,
        ),
        selectedIcon: ImageIcon(
          AssetImage("assets/images/navbar_dashboard.png"),
          color: AppColor.Green,
        ),
        label: "Dashboard",
      ),
      route: Routes.Dashboard,
    ),
    AppNavbarItem(
      item: NavigationDestination(
        icon: ImageIcon(
          AssetImage("assets/images/navbar_lahanku.png"),
          color: Colors.grey,
        ),
        selectedIcon: ImageIcon(
          AssetImage("assets/images/navbar_lahanku.png"),
          color: AppColor.Green,
        ),
        label: "Lahanku",
      ),
      route: Routes.Lahanku,
    ),
    AppNavbarItem(
      item: NavigationDestination(
        icon: ImageIcon(
          AssetImage("assets/images/navbar_belanja.png"),
          color: Colors.grey,
        ),
        selectedIcon: ImageIcon(
          AssetImage("assets/images/navbar_belanja.png"),
          color: AppColor.Green,
        ),
        label: "Belanja",
      ),
      route: Routes.Belanja,
    ),
    AppNavbarItem(
      item: NavigationDestination(
        icon: ImageIcon(
          AssetImage("assets/images/navbar_pesan.png"),
          color: Colors.grey,
        ),
        selectedIcon: ImageIcon(
          AssetImage("assets/images/navbar_pesan.png"),
          color: AppColor.Green,
        ),
        label: "Pesan",
      ),
      route: Routes.Pesan,
    ),
    AppNavbarItem(
      item: NavigationDestination(
        icon: ImageIcon(
          AssetImage("assets/images/navbar_profile.png"),
          color: Colors.grey,
        ),
        selectedIcon: ImageIcon(
          AssetImage("assets/images/navbar_profile.png"),
          color: AppColor.Green,
        ),
        label: "Profil",
      ),
      route: Routes.Profile,
    ),
  ];
  int selectedIndex = 0;
  try {
    selectedIndex = items.indexWhere((element) => element.route == selectedRoute);
  } catch (e) {
    selectedIndex = 0;
  }

  return NavigationBar(
    selectedIndex: (selectedIndex >= 0) ? selectedIndex : 0,
    destinations: items.map((e) => e.item).toList(),
    onDestinationSelected: (index) {
      debugPrint("DARI MODAL" + selectedRoute);
      onItemClicked(items[index].route, index);
    },
  );
}
