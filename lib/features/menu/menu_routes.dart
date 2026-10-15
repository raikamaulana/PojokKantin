import 'package:flutter/material.dart';
import '../../core/route_names.dart';
import '../../shared/placeholder_page.dart';
import 'home_page.dart';

class MenuRoutes {
  MenuRoutes._();

  static Map<String, WidgetBuilder> get routes => {
    // Halaman pembeli
    AppRoutes.home: (context) => const HomePage(),

    AppRoutes.kantinMenuList: (context) => const PlaceholderPage(
      title: 'Daftar Menu Kantin',
    ),

    AppRoutes.menuDetail: (context) => const PlaceholderPage(
      title: 'Detail Menu',
    ),

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