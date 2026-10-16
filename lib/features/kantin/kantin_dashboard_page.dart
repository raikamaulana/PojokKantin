import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/route_names.dart';
import '../../core/utils.dart';
import '../../shared/app_drawer.dart';
import '../../shared/status_chip.dart';

class KantinDashboardPage extends StatelessWidget {
  const KantinDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final cs = t.colorScheme;

    // Kantin milik penjual yang sedang login (dummy: kantin pertama).
    final kantin = DummyData.kantin.first;
    final pesananKantin =
        DummyData.pesanan.where((p) => p.kantinId == kantin.id).toList();
    final pesananBaru =
        pesananKantin.where((p) => p.status == 'Diproses').length;
    final pendapatan = pesananKantin.fold<int>(0, (sum, p) => sum + p.total);
    final jumlahMenu = DummyData.menuDariKantin(kantin.id).length;

    // Drawer tampil sebagai akun penjual.
    final u = DummyData.currentUser;
    final penjual = AppUser(
      nama: u.nama,
      email: u.email,
      username: u.username,
      nim: u.nim,
      nomorHp: u.nomorHp,
      identitas: u.identitas,
      role: 'penjual',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Kantin')),
      drawer: AppDrawer(user: penjual),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.storefront, color: cs.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kantin.nama,
                          overflow: TextOverflow.ellipsis,
                          style: t.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${kantin.jamBuka} - ${kantin.jamTutup} • ${kantin.lokasi}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const StatusChip(status: 'Aktif'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _Stat(
                    icon: Icons.restaurant_menu,
                    label: 'Menu',
                    value: '$jumlahMenu',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _Stat(
                    icon: Icons.receipt_long,
                    label: 'Pesanan baru',
                    value: '$pesananBaru',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _Stat(
              icon: Icons.payments_outlined,
              label: 'Pendapatan hari ini',
              value: formatRupiah(pendapatan),
            ),
            const SizedBox(height: 20),
            Text(
              'Kelola Kantin',
              style: t.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const _Shortcut(
              icon: Icons.restaurant_menu,
              title: 'Menu Saya',
              subtitle: 'Tambah, edit, dan hapus menu',
              route: AppRoutes.kantinMenu,
            ),
            const _Shortcut(
              icon: Icons.inbox_outlined,
              title: 'Pesanan Masuk',
              subtitle: 'Perbarui status pesanan',
              route: AppRoutes.kantinPesanan,
            ),
            const _Shortcut(
              icon: Icons.store_mall_directory_outlined,
              title: 'Profil Kantin',
              subtitle: 'Lihat dan ubah info kantin',
              route: AppRoutes.kantinProfil,
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _Stat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: t.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: t.colorScheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: t.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: t.textTheme.bodySmall
                        ?.copyWith(color: const Color(0xFF6B5F5F)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Shortcut extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String route;

  const _Shortcut({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: t.colorScheme.primary),
        title: Text(
          title,
          style: t.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
