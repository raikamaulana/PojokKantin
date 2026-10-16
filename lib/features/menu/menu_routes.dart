import 'package:flutter/material.dart';
import '../../core/route_names.dart';
import '../../shared/placeholder_page.dart';
import '../../core/models.dart';
import 'home_page.dart';
import 'kantin_menu_list_page.dart';
import 'menu_detail_page.dart';

class MenuRoutes {
  MenuRoutes._();

  static Map<String, WidgetBuilder> get routes => {
    // Halaman pembeli
    AppRoutes.home: (context) => const HomePage(),

    AppRoutes.kantinMenuList: (context) {
      final kantinId = ModalRoute.of(context)?.settings.arguments as String?;
      return KantinMenuListPage(kantinId: kantinId);
    },

    AppRoutes.menuDetail: (context) {
      final menu = ModalRoute.of(context)?.settings.arguments as MenuKantin;
      return MenuDetailPage(menu: menu);
    },

    // Halaman penjual (CRUD menu)
    AppRoutes.kantinMenu: (context) => const PlaceholderPage(
      title: 'Menu Saya',
    ),

    AppRoutes.kantinMenuTambah: (context) => const PlaceholderPage(
      title: 'Tambah Menu',
    ),

    AppRoutes.kantinMenuEdit: (context) => const PlaceholderPage(
      title: 'Edit Menu',
    ),
  };
}