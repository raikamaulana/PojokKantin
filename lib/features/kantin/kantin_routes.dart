import 'package:flutter/material.dart';
import '../../core/route_names.dart';
import 'admin_pengajuan_detail_page.dart';
import 'admin_pengajuan_page.dart';
import 'kantin_dashboard_page.dart';
import 'kantin_daftar_page.dart';
import 'kantin_edit_page.dart';
import 'kantin_menunggu_page.dart';
import 'kantin_profil_page.dart';

class KantinRoutes {
  KantinRoutes._();

  static Map<String, WidgetBuilder> get routes => {
    // Pendaftaran kantin
    AppRoutes.kantinDaftar: (context) => const KantinDaftarPage(),

    AppRoutes.kantinMenunggu: (context) => const KantinMenungguPage(),

    // Dashboard penjual
    AppRoutes.kantinDashboard: (context) => const KantinDashboardPage(),

    AppRoutes.kantinProfil: (context) => const KantinProfilPage(),

    AppRoutes.kantinProfilEdit: (context) => const KantinEditPage(),

    // Panel admin
    AppRoutes.adminPengajuan: (context) => const AdminPengajuanPage(),

    AppRoutes.adminPengajuanDetail: (context) =>
        const AdminPengajuanDetailPage(),
  };
}
