
import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/route_names.dart';
import '../../core/theme.dart';

class RiwayatPesananPage extends StatelessWidget {
  const RiwayatPesananPage({super.key});

  String _rupiah(int nominal) {
    final angka = nominal.toString();
    final hasil = StringBuffer();

    for (var i = 0; i < angka.length; i++) {
      if (i > 0 && (angka.length - i) % 3 == 0) {
        hasil.write('.');
      }
      hasil.write(angka[i]);
    }

    return 'Rp $hasil';
  }

  Color _warnaStatus(String status) {
    switch (status.toLowerCase()) {
      case 'siap diambil':
        return Colors.green;
      case 'selesai':
        return Colors.blue;
      case 'dibatalkan':
        return Colors.red;
      default:
        return AppTheme.accent;
    }
  }

  IconData _ikonStatus(String status) {
    switch (status.toLowerCase()) {
      case 'siap diambil':
        return Icons.check_circle_outline;
      case 'selesai':
        return Icons.task_alt_outlined;
      case 'dibatalkan':
        return Icons.cancel_outlined;
      default:
        return Icons.hourglass_top_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pesanan = DummyData.pesanan.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
      ),
      backgroundColor: AppTheme.background,
      body: pesanan.isEmpty
          ? _buildKosong()
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Pesanan Saya',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Lihat status dan ringkasan pesananmu.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                ...pesanan.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _buildKartuPesanan(context, item),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildKosong() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 72,
              color: AppTheme.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Belum Ada Pesanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pesanan yang kamu buat akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKartuPesanan(
    BuildContext context,
    Pesanan item,
  ) {
    final kantin = DummyData.cariKantin(item.kantinId);
    final warna = _warnaStatus(item.status);

    return Card(
      color: AppTheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppTheme.tint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.receipt_long_outlined,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.id,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        kantin?.nama ?? 'Kantin',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: warna.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _ikonStatus(item.status),
                        size: 14,
                        color: warna,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.status,
                        style: TextStyle(
                          color: warna,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 26),
            ...item.items.map(
              (detail) {
                final menu = DummyData.cariMenu(detail.menuId);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          menu?.nama ?? detail.menuId,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${detail.jumlah}x',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total pembayaran',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  _rupiah(item.total),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 42,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primary,
                  side: const BorderSide(color: AppTheme.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.pesananDetail,
                    arguments: item,
                  );
                },
                child: const Text('Lihat Detail Pesanan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
