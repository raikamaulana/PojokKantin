
import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/theme.dart';

class DetailPesananPage extends StatelessWidget {
  const DetailPesananPage({super.key});

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
    final args = ModalRoute.of(context)?.settings.arguments;
    final Pesanan? pesanan = args is Pesanan ? args : null;

    if (pesanan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Pesanan')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Data pesanan tidak ditemukan. '
              'Silakan buka detail dari Riwayat Pesanan.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final kantin = DummyData.cariKantin(pesanan.kantinId);
    final warna = _warnaStatus(pesanan.status);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: AppTheme.surface,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppTheme.divider),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    _ikonStatus(pesanan.status),
                    size: 54,
                    color: warna,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    pesanan.status,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: warna,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Status pesanan saat ini',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.tint,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      pesanan.id,
                      style: const TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _judulBagian(
            Icons.storefront_outlined,
            'Informasi Kantin',
          ),
          const SizedBox(height: 10),
          _kartuInformasi([
            _barisInfo(
              'Nama kantin',
              kantin?.nama ?? 'Kantin tidak tersedia',
            ),
            _barisInfo(
              'Lokasi',
              kantin?.lokasi ?? '-',
            ),
            _barisInfo(
              'Jam pengambilan',
              pesanan.jamAmbil,
            ),
          ]),
          const SizedBox(height: 20),
          _judulBagian(
            Icons.receipt_long_outlined,
            'Rincian Pesanan',
          ),
          const SizedBox(height: 10),
          _kartuInformasi([
            ...pesanan.items.map((detail) {
              final menu = DummyData.cariMenu(detail.menuId);
              final namaMenu = menu?.nama ?? detail.menuId;
              final harga = menu?.harga ?? 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppTheme.tint,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.restaurant_outlined,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namaMenu,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${detail.jumlah} x ${_rupiah(harga)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _rupiah(harga * detail.jumlah),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 8),
            const SizedBox(height: 8),
            _barisInfo(
              'Total pembayaran',
              _rupiah(pesanan.total),
              nilaiTebal: true,
              warnaNilai: AppTheme.accent,
            ),
          ]),
          const SizedBox(height: 20),
          _judulBagian(
            Icons.payments_outlined,
            'Metode Pembayaran',
          ),
          const SizedBox(height: 10),
          _kartuInformasi([
            _barisInfo(
              'Metode',
              pesanan.metodePembayaran,
            ),
            _barisInfo(
              'Total',
              _rupiah(pesanan.total),
              nilaiTebal: true,
            ),
          ]),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Riwayat Pesanan'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primary,
                side: const BorderSide(color: AppTheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _judulBagian(IconData ikon, String judul) {
    return Row(
      children: [
        Icon(ikon, color: AppTheme.primary, size: 22),
        const SizedBox(width: 8),
        Text(
          judul,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _kartuInformasi(List<Widget> children) {
    return Card(
      color: AppTheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(children: children),
      ),
    );
  }

  Widget _barisInfo(
    String label,
    String nilai, {
    bool nilaiTebal = false,
    Color? warnaNilai,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              nilai,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13,
                fontWeight: nilaiTebal
                    ? FontWeight.bold
                    : FontWeight.w500,
                color: warnaNilai ?? AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
