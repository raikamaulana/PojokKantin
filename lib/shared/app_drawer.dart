import 'package:flutter/material.dart';

import '../core/dummy_data.dart';
import '../core/models.dart';
import '../core/route_names.dart';

class AppDrawer extends StatelessWidget {
  final AppUser? user;

  const AppDrawer({
    super.key,
    this.user,
  });

  void _navigate(BuildContext context, String routeName) {
    Navigator.pop(context);
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = user ?? DummyData.currentUser;
    final colorScheme = Theme.of(context).colorScheme;
    final isSeller = currentUser.role == 'penjual';
    final isAdmin = currentUser.role == 'admin';

    final badges = <String>[
      if (isAdmin)
        'Admin'
      else ...[
        if (currentUser.identitas.isNotEmpty)
          currentUser.identitas,
        if (isSeller) 'Penjual',
      ],
    ];

    return Drawer(
      child: Column(
        children: [
          // Header profil
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 24,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            color: colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person_outline,
                    size: 32,
                    color: Color(0xFF800000),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  currentUser.nama,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentUser.email,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),

                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: badges.map((badge) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Daftar menu sidebar
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Profil Saya'),
                  onTap: () => _navigate(
                    context,
                    AppRoutes.profil,
                  ),
                ),

                if (!isSeller && !isAdmin) ...[
                  _sectionLabel(context, 'LAYANAN KANTIN'),
                  ListTile(
                    leading: const Icon(Icons.storefront_outlined),
                    title: const Text('Daftar Jadi Penjual'),
                    subtitle: const Text(
                      'Mulai berjualan di Pojok Kantin',
                    ),
                    onTap: () => _navigate(
                      context,
                      AppRoutes.kantinDaftar,
                    ),
                  ),
                ],

                if (isSeller) ...[
                  _sectionLabel(context, 'PANEL PENJUAL'),
                  ListTile(
                    leading: const Icon(Icons.dashboard_outlined),
                    title: const Text('Dashboard Kantin'),
                    onTap: () => _navigate(
                      context,
                      AppRoutes.kantinDashboard,
                    ),
                  ),
                ],

                if (isAdmin) ...[
                  _sectionLabel(context, 'ADMIN'),
                  ListTile(
                    leading: const Icon(Icons.fact_check_outlined),
                    title: const Text('Cek Pengajuan Kantin'),
                    onTap: () => _navigate(
                      context,
                      AppRoutes.adminPengajuan,
                    ),
                  ),
                ],

                const SizedBox(height: 12),
                _sectionLabel(context, 'AKUN'),

                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: colorScheme.error,
                  ),
                  title: Text(
                    'Keluar Akun',
                    style: TextStyle(
                      color: colorScheme.error,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 6,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}