import 'package:flutter/material.dart';

import '../core/route_names.dart';
import '../core/theme.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
  });

  static const List<String> _routes = [
    AppRoutes.home,
    AppRoutes.pesanan,
    AppRoutes.keranjang,
    AppRoutes.profil,
  ];

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      _routes[index],
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.tint,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        child: SizedBox(
          height: 72,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) => _onTap(context, index),

            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long),
                label: 'Pesanan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(Icons.shopping_cart),
                label: 'Keranjang',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}