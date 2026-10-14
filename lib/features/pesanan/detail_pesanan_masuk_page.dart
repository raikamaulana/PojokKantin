import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/theme.dart';

class DetailPesananMasukPage extends StatelessWidget {
  const DetailPesananMasukPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final pesanan = arguments is Pesanan ? arguments : null;

    if (pesanan == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Pesanan Masuk'),
        ),
        body: const Center(
          child: Text('Data pesanan tidak ditemukan.'),
        ),
      );
    }

    final kantin = DummyData.cariKantin(pesanan.kantinId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan Masuk'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _BagianKartu(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informasi Pesanan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _BarisInfo(
                  label: 'Nomor pesanan',
                  value: pesanan.id,
                ),
                _BarisInfo(
                  label: 'Nama pembeli',
                  value: pesanan.pembeli,
                ),
                _BarisInfo(
                  label: 'Kantin',
                  value: kantin?.nama ?? pesanan.kantinId,
                ),
                _BarisInfo(
                  label: 'Lokasi kantin',
                  value: kantin?.lokasi ?? '-',
                ),
                _BarisInfo(
                  label: 'Waktu pengambilan',
                  value: pesanan.jamAmbil,
                ),
                _BarisInfo(
                  label: 'Metode pembayaran',
                  value: pesanan.metodePembayaran,
                ),
                _BarisInfo(
                  label: 'Status',
                  value: pesanan.status,
                  valueColor: AppTheme.accent,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _BagianKartu(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daftar Menu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                ...pesanan.items.map((item) {
                  final menu = DummyData.cariMenu(item.menuId);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.restaurant_menu,
                          color: AppTheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu?.nama ?? item.menuId,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item.jumlah} x Rp${menu?.harga ?? 0}',
                                style: const TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Rp${(menu?.harga ?? 0) * item.jumlah}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(color: AppTheme.divider),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total pembayaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp${pesanan.total}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Pesanan Masuk'),
            ),
          ),
        ],
      ),
    );
  }
}

class _BagianKartu extends StatelessWidget {
  const _BagianKartu({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class _BarisInfo extends StatelessWidget {
  const _BarisInfo({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: valueColor ?? AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}