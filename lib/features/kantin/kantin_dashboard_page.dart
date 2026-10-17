import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/utils.dart';
import '../../shared/app_drawer.dart';
import '../../shared/status_chip.dart';
import '../../shared/kantin_bottom_nav.dart';
import '../../core/theme.dart';

class KantinDashboardPage extends StatelessWidget {
  const KantinDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    // Kantin milik penjual yang sedang login (dummy: kantin pertama).
    final kantin = DummyData.kantin.first;
    final pesananKantin =
        DummyData.pesanan.where((p) => p.kantinId == kantin.id).toList();
    final pesananBaru =
        pesananKantin.where((p) => p.status == 'Diproses').length;
    final pendapatan = pesananKantin.fold<int>(0, (sum, p) => sum + p.total);
    final jumlahMenu = DummyData.menuDariKantin(kantin.id).length;

    // Menghitung total jumlah menu yang dipesan
    final jumlahDipesan = <String, int>{};

    for (final pesanan in pesananKantin) {
      if (pesanan.status != 'Selesai') continue;

      for (final item in pesanan.items) {
        jumlahDipesan[item.menuId] =
            (jumlahDipesan[item.menuId] ?? 0) + item.jumlah;
      }
    }

    // Mengurutkan menu berdasarkan jumlah yang paling banyak dipesan
    final menuTerlaris = DummyData.menuDariKantin(kantin.id);

    menuTerlaris.sort((a, b) {
      return (jumlahDipesan[b.id] ?? 0)
          .compareTo(jumlahDipesan[a.id] ?? 0);
    });

    final topMenu = menuTerlaris.take(3).toList();

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
      backgroundColor: AppTheme.background,
      drawer: AppDrawer(user: penjual),

      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 68,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
        ),
        title: const Text(
          'Dashboard Kantin',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBar: const KantinBottomNav(currentIndex: 0),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFFF5F6),
              Color(0xFFF8DBE1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Foto kantin
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Image.asset(
                        kantin.imagePath,
                        width: double.infinity,
                        height: 170,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 170,
                            color: AppTheme.tint,
                            child: const Icon(
                              Icons.storefront_rounded,
                              size: 64,
                              color: AppTheme.primary,
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  kantin.nama,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                              const StatusChip(status: 'Aktif'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 17,
                                color: AppTheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  kantin.lokasi,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                size: 17,
                                color: AppTheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${kantin.jamBuka} - ${kantin.jamTutup}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                label: 'Total Pendapatan',
                value: formatRupiah(pendapatan),
              ),
              const SizedBox(height: 20),
              const Text(
                'Menu Paling Banyak Dibeli',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Menu favorit berdasarkan data pesanan.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 14),

              if (topMenu.isEmpty)
                const Text('Belum ada menu.')
              else
                ...topMenu.map((menu) {
                  final jumlah = jumlahDipesan[menu.id] ?? 0;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            menu.imagePath,
                            width: 58,
                            height: 58,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 58,
                                height: 58,
                                color: AppTheme.tint,
                                child: const Icon(
                                  Icons.restaurant,
                                  color: AppTheme.primary,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu.nama,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formatRupiah(menu.harga),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$jumlah',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary,
                              ),
                            ),
                            const Text(
                              'Dibeli',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
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
