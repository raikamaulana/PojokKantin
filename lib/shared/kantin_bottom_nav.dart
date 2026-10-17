import 'package:flutter/material.dart';

/// Navigasi utama untuk empat halaman pemilik kantin.
class KantinBottomNav extends StatelessWidget {
  final int currentIndex;

  const KantinBottomNav({super.key, required this.currentIndex});

  static const List<String> _routes = [
    '/kantin/dashboard',
    '/kantin/menu',
    '/kantin/pesanan',
    '/kantin/profil',
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
      color: Color(0xFFF8DBE1),
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
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_outlined),
                activeIcon: Icon(Icons.restaurant_menu),
                label: 'Kelola Menu',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long),
                label: 'Pesanan',
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
