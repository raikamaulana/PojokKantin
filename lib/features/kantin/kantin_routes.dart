import 'package:flutter/material.dart';
import '../../core/route_names.dart';
import '../../shared/placeholder_page.dart';

class KantinRoutes {
  KantinRoutes._();

  static Map<String, WidgetBuilder> get routes => {
    // Pendaftaran kantin
    AppRoutes.kantinDaftar: (context) => const PlaceholderPage(
      title: 'Daftar Jadi Penjual',
    ),

    AppRoutes.kantinMenunggu: (context) => const PlaceholderPage(
      title: 'Menunggu Persetujuan',
    ),

    // Dashboard penjual
    AppRoutes.kantinDashboard: (context) => const PlaceholderPage(
      title: 'Dashboard Kantin',
    ),

    AppRoutes.kantinProfil: (context) => const PlaceholderPage(
      title: 'Profil Kantin',
    ),

    AppRoutes.kantinProfilEdit: (context) => const PlaceholderPage(
      title: 'Edit Kantin',
    ),

    // Panel admin
    AppRoutes.adminPengajuan: (context) => const PlaceholderPage(
      title: 'Cek Pengajuan Kantin',
    ),

    AppRoutes.adminPengajuanDetail: (context) => const PlaceholderPage(
      title: 'Detail Pengajuan Kantin',
    ),
  };
}