import 'package:flutter/material.dart';

import '../core/dummy_data.dart';
import '../core/models.dart';
import '../core/route_names.dart';
import '../core/theme.dart';

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
    final isSeller = currentUser.role == 'penjual';
    final isAdmin = currentUser.role == 'admin';

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header profil
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 20),
            color: AppTheme.primary,
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Branding dan tombol tutup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Pojok Kantin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '— UNSIKA —',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                        tooltip: 'Tutup menu',
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Profil pengguna
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 27,
                        backgroundColor: AppTheme.tint,
                        backgroundImage: AssetImage(
                          'assets/images/profile/foto-profil.jpg',
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser.nama,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 3),

                            Text(
                              currentUser.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),

                            const SizedBox(height: 7),

                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: [
                                _profileBadge(currentUser.identitas),

                                if (currentUser.role == 'penjual')
                                  _profileBadge('Penjual'),

                                if (currentUser.role == 'admin')
                                  _profileBadge('Admin'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppTheme.tint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: AppTheme.primary,
                      size: 22,
                    ),
                  ),
                  title: const Text(
                    'Profil Saya',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                  onTap: () => _navigate(context, AppRoutes.profil),
                ),

                if (!isSeller && !isAdmin) ...[
                  _sectionLabel(context, 'LAYANAN KANTIN'),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 1,
                    ),

                    leading: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppTheme.tint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.storefront_outlined,
                        color: AppTheme.primary,
                        size: 22,
                      ),
                    ),

                    title: const Text(
                      'Daftar Jadi Penjual',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),

                    subtitle: const Text(
                      'Mulai berjualan di Pojok Kantin',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),

                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),

                    onTap: () => _navigate(context, AppRoutes.kantinDaftar),
                  ),
                ],

                if (isSeller) ...[
                  _sectionLabel(context, 'PANEL PENJUAL'),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    leading: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppTheme.tint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.dashboard_outlined,
                        color: AppTheme.primary,
                        size: 22,
                      ),
                    ),
                    title: const Text(
                      'Dashboard Kantin',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    subtitle: const Text(
                      'Kelola kantin dan pesanan',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                    onTap: () => _navigate(context, AppRoutes.kantinDashboard),
                  ),
                ],

                if (isAdmin) ...[
                  _sectionLabel(context, 'ADMIN'),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    leading: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppTheme.tint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.fact_check_outlined,
                        color: AppTheme.primary,
                        size: 22,
                      ),
                    ),
                    title: const Text(
                      'Cek Pengajuan Kantin',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                    onTap: () => _navigate(
                      context,
                      AppRoutes.adminPengajuan,
                    ),
                  ),
                ],

                const SizedBox(height: 12),
                _sectionLabel(context, 'AKUN'),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppTheme.tint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.logout_rounded,
                      color: AppTheme.accent,
                      size: 22,
                    ),
                  ),
                  title: const Text(
                    'Keluar Akun',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accent,
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
        
          // Footer aplikasi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppTheme.divider,
                  width: 1,
                ),
              ),
            ),
            child: const Text(
              'Pojok Kantin v1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFFAAAAAA),
                fontWeight: FontWeight.w400,
              ),
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

  Widget _profileBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}