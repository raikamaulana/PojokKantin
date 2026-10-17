import 'package:flutter/material.dart';

import 'core/route_names.dart';
import 'core/routes.dart';
import 'core/theme.dart';

void main() {
  runApp(const PojokKantinApp());
}

class PojokKantinApp extends StatelessWidget {
  const PojokKantinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pojok Kantin',
      debugShowCheckedModeBanner: false,

      // Tema global Pojok Kantin
      theme: AppTheme.lightTheme,

      // Halaman pertama saat aplikasi dibuka
      initialRoute: AppRoutes.splash,

      // Gabungan 26 route dari seluruh anggota
      routes: AppRouter.routes,
    );
  }
}
