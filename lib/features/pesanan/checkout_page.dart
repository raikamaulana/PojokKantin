
import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/route_names.dart';
import '../../core/theme.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late final List<_ItemCheckout> _items;

  String _jamAmbil = '12.15';
  String _metodePembayaran = 'Tunai di kantin';

  final List<String> _pilihanJam = [
    '12.15',
    '12.30',
    '12.45',
    '13.00',
    '13.15',
  ];

  final List<String> _pilihanPembayaran = [
    'Tunai di kantin',
    'QRIS',
    'E-wallet',
  ];

  @override
  void initState() {
    super.initState();

    // Data contoh sementara, disesuaikan dengan desain.
    _items = [
      _ItemCheckout(
        menu: DummyData.cariMenu('M001')!,
        jumlah: 1,
      ),
      _ItemCheckout(
        menu: DummyData.cariMenu('M003')!,
        jumlah: 1,
      ),
    ];
  }

  int get _total =>
      _items.fold(0, (total, item) => total + item.subtotal);

  Kantin? get _kantin => _items.isEmpty
      ? null
      : DummyData.cariKantin(_items.first.menu.kantinId);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text('Tidak ada item untuk checkout.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildBagianJudul(
                        ikon: Icons.receipt_long_outlined,
                        judul: 'Ringkasan Pesanan',
                      ),
                      const SizedBox(height: 12),
                      _buildRingkasanItem(),
                      const SizedBox(height: 24),
                      _buildBagianJudul(
                        ikon: Icons.location_on_outlined,
                        judul: 'Lokasi Pengambilan',
                      ),
                      const SizedBox(height: 12),
                      _buildLokasi(),
                      const SizedBox(height: 24),
                      _buildBagianJudul(
                        ikon: Icons.schedule_outlined,
                        judul: 'Jam Pengambilan',
                      ),
                      const SizedBox(height: 12),
                      _buildPilihanJam(),
                      const SizedBox(height: 24),
                      _buildBagianJudul(
                        ikon: Icons.account_balance_wallet_outlined,
                        judul: 'Metode Pembayaran',
                      ),
                      const SizedBox(height: 12),
                      _buildPilihanPembayaran(),
                    ],
                  ),
                ),
                _buildRingkasanTotal(),
              ],
            ),
    );
  }

  Widget _buildBagianJudul({
    required IconData ikon,
    required String judul,
  }) {
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

  Widget _buildRingkasanItem() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ..._items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.tint,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item.menu.kategori == 'Minuman'
                            ? Icons.local_cafe_outlined
                            : Icons.restaurant_outlined,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.menu.nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.jumlah} item',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _rupiah(item.subtotal),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total item',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
                Text(
                  '${_items.fold<int>(0, (sum, item) => sum + item.jumlah)} item',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLokasi() {
    final kantin = _kantin;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.storefront_outlined,
              color: AppTheme.primary,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kantin?.nama ?? 'Kantin tidak tersedia',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    kantin?.lokasi ?? '-',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pesanan diambil langsung di kantin.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


Widget _buildPilihanJam() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: RadioGroup<String>(
        groupValue: _jamAmbil,
        onChanged: (value) {
          if (value == null) return;
          setState(() => _jamAmbil = value);
        },
        child: Column(
          children: _pilihanJam.map((jam) {
            return RadioListTile<String>(
              value: jam,
              activeColor: AppTheme.primary,
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                jam,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}


Widget _buildPilihanPembayaran() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: RadioGroup<String>(
        groupValue: _metodePembayaran,
        onChanged: (value) {
          if (value == null) return;
          setState(() => _metodePembayaran = value);
        },
        child: Column(
          children: _pilihanPembayaran.map((metode) {
            final ikon = switch (metode) {
              'Tunai di kantin' => Icons.payments_outlined,
              'QRIS' => Icons.qr_code_2_outlined,
              _ => Icons.account_balance_wallet_outlined,
            };

            return RadioListTile<String>(
              value: metode,
              activeColor: AppTheme.primary,
              contentPadding: EdgeInsets.zero,
              dense: true,
              secondary: Icon(
                ikon,
                color: AppTheme.primary,
              ),
              title: Text(
                metode,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}

  Widget _buildRingkasanTotal() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          top: BorderSide(color: AppTheme.divider),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Pembayaran',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  _rupiah(_total),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  foregroundColor: Colors.white,
                ),
                onPressed: _items.isEmpty ? null : _buatPesanan,
                child: const Text(
                  'Buat Pesanan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _buatPesanan() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle_outline,
            color: AppTheme.primary,
            size: 48,
          ),
          title: const Text('Pesanan Siap Dibuat'),
          content: Text(
            'Simulasi checkout berhasil.\n\n'
            'Jam pengambilan: $_jamAmbil\n'
            'Pembayaran: $_metodePembayaran\n'
            'Total: ${_rupiah(_total)}\n\n'
            'Belum ada pesanan yang disimpan.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Kembali'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushNamed(context, AppRoutes.pesanan);
              },
              child: const Text('Lihat Pesanan'),
            ),
          ],
        );
      },
    );
  }
}

class _ItemCheckout {
  final MenuKantin menu;
  final int jumlah;

  const _ItemCheckout({
    required this.menu,
    required this.jumlah,
  });

  int get subtotal => menu.harga * jumlah;
}
