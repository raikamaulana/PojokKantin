import 'package:flutter/material.dart';
import '../../core/route_names.dart';
import '../../shared/placeholder_page.dart';

class PesananRoutes {
  PesananRoutes._();

  static Map<String, WidgetBuilder> get routes => {
    // Halaman pembeli
    AppRoutes.keranjang: (context) => const PlaceholderPage(
      title: 'Keranjang',
    ),

    AppRoutes.checkout: (context) => const PlaceholderPage(
      title: 'Checkout',
    ),

    AppRoutes.pesanan: (context) => const PlaceholderPage(
      title: 'Riwayat Pesanan',
    ),

    AppRoutes.pesananDetail: (context) => const PlaceholderPage(
      title: 'Detail Pesanan',
    ),

    // Halaman penjual
    AppRoutes.kantinPesanan: (context) => const PlaceholderPage(
      title: 'Pesanan Masuk',
    ),

    AppRoutes.kantinPesananDetail: (context) => const PlaceholderPage(
      title: 'Detail Pesanan Masuk',
    ),
  };
}