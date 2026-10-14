import 'package:flutter/material.dart';
import '../../core/route_names.dart';
import '../../shared/placeholder_page.dart';
import 'keranjang_page.dart';
import 'checkout_page.dart';

class PesananRoutes {
  PesananRoutes._();

  static Map<String, WidgetBuilder> get routes => {
    // Halaman pembeli
    AppRoutes.keranjang: (context) => const KeranjangPage(),

    AppRoutes.checkout: (context) => const CheckoutPage(),

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