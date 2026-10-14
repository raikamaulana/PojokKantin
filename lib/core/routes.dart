
import 'package:flutter/material.dart';

import '../features/auth/auth_routes.dart';
import '../features/kantin/kantin_routes.dart';
import '../features/menu/menu_routes.dart';
import '../features/pesanan/pesanan_routes.dart';

class AppRouter {
  AppRouter._();

  static Map<String, WidgetBuilder> get routes => {
    // Ahmad — Auth & Profil
    ...AuthRoutes.routes,

    // Dandy — Kantin & Admin
    ...KantinRoutes.routes,

    // Raika — Menu & Beranda
    ...MenuRoutes.routes,

    // Sukma — Pesanan
    ...PesananRoutes.routes,
  };
}
