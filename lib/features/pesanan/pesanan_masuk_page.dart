import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/route_names.dart';
import '../../core/theme.dart';

class PesananMasukPage extends StatelessWidget {
  const PesananMasukPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pesananList = DummyData.pesanan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Masuk'),
      ),
      body: pesananList.isEmpty
          ? const Center(
              child: Text('Belum ada pesanan masuk'),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: pesananList.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _KartuPesananMasuk(
                  pesanan: pesananList[index],
                );
              },
            ),
    );
  }
}

class _KartuPesananMasuk extends StatelessWidget {
  const _KartuPesananMasuk({
    required this.pesanan,
  });

  final Pesanan pesanan;

  @override
  Widget build(BuildContext context) {
    final warnaStatus = switch (pesanan.status.toLowerCase()) {
      'diproses' => AppTheme.accent,
      'siap diambil' => Colors.green,
      'selesai' => Colors.blue,
      'dibatalkan' => Colors.red,
      _ => AppTheme.textSecondary,
    };

    return Card(
      color: AppTheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pesanan.id,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pesanan.pembeli,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: warnaStatus.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    pesanan.status,
                    style: TextStyle(
                      color: warnaStatus,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: AppTheme.divider),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 18,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Waktu ambil: ${pesanan.jamAmbil}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.receipt_long_outlined,
                  size: 18,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${pesanan.items.length} jenis menu',
                  ),
                ),
                Text(
                  'Rp${pesanan.total}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.kantinPesananDetail,
                    arguments: pesanan,
                  );
                },
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Lihat Detail Pesanan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}