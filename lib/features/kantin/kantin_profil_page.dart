import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/route_names.dart';
import '../../shared/status_chip.dart';
import '../../core/models.dart';
import '../../core/theme.dart';
import '../../shared/app_drawer.dart';
import '../../shared/kantin_bottom_nav.dart';
import 'kantin_widgets.dart';

class KantinProfilPage extends StatelessWidget {
  const KantinProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final kantin = DummyData.kantin.first;

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

      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 68,
        title: const Text(
          'Profil Kantin',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
        ),
      ),

      drawer: AppDrawer(user: penjual),

      bottomNavigationBar: const KantinBottomNav(
        currentIndex: 3,
      ),

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
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  kantin.imagePath,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 180,
                      color: AppTheme.tint,
                      child: const Icon(
                        Icons.storefront_outlined,
                        size: 64,
                        color: AppTheme.primary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Card(
                margin: EdgeInsets.zero,
                color: AppTheme.surface,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppTheme.divider),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Informasi Kantin',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                          StatusChip(status: kantin.status),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(),

                      KantinInfoRow(
                        icon: Icons.storefront_outlined,
                        label: 'Nama Kantin',
                        value: kantin.nama,
                      ),

                      const Divider(),

                      KantinInfoRow(
                        icon: Icons.notes,
                        label: 'Deskripsi',
                        value: kantin.deskripsi,
                      ),
                      const Divider(),
                      KantinInfoRow(
                        icon: Icons.location_on_outlined,
                        label: 'Lokasi',
                        value: kantin.lokasi,
                      ),
                      const Divider(),
                      KantinInfoRow(
                        icon: Icons.schedule,
                        label: 'Jam operasional',
                        value: '${kantin.jamBuka} - ${kantin.jamTutup}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.kantinProfilEdit),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Edit Kantin'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), 
    );
  }
}
