
import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../shared/app_bottom_nav.dart';
import '../../shared/app_drawer.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  late final List<_ItemKeranjang> _items;

  @override
  void initState() {
    super.initState();

    // Contoh isi keranjang sementara.
    _items = [
      _ItemKeranjang(
        menu: DummyData.cariMenu('M001')!,
        jumlah: 1,
      ),
      _ItemKeranjang(
        menu: DummyData.cariMenu('M003')!,
        jumlah: 1,
      ),
    ];
  }

  int get _total =>
      _items.fold(0, (total, item) => total + item.subtotal);

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

  void _ubahJumlah(_ItemKeranjang item, int perubahan) {
    setState(() {
      item.jumlah += perubahan;

      if (item.jumlah <= 0) {
        _items.remove(item);
      }
    });
  }

  void _hapusItem(_ItemKeranjang item) {
    setState(() {
      _items.remove(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item dihapus dari keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final kantin = _items.isNotEmpty
        ? DummyData.cariKantin(_items.first.menu.kantinId)
        : null;

    return Scaffold(
      backgroundColor: AppTheme.background,
      drawer: const AppDrawer(),

      // Top Bar
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
          'Keranjang',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Bottom Navigation: index 2 = Keranjang
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),

      body: SizedBox.expand(
        child: Stack(
          children: [
            // Background gradasi seperti Home
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
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
              ),
            ),

            // Konten keranjang
            _items.isEmpty
                ? _buildKosong()
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            if (kantin != null) ...[
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      width: 64,
                                      height: 64,
                                      child: Image.asset(
                                        kantin.imagePath,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) => const Icon(
                                          Icons.storefront_outlined,
                                          color: AppTheme.primary,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          kantin.nama,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          kantin.lokasi,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppTheme.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],

                            ..._items.map(_buildItem),
                          ],
                        ),
                      ),

                      // Tetap di bawah daftar item
                      _buildRingkasan(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(_ItemKeranjang item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 64,
                height: 64,
                child: Image.asset(
                  item.menu.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.restaurant_outlined,
                    color: AppTheme.primary,
                    size: 30,
                  ),
                ),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _rupiah(item.menu.harga),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _tombolJumlah(
                        ikon: Icons.remove,
                        aksi: () => _ubahJumlah(item, -1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          '${item.jumlah}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      _tombolJumlah(
                        ikon: Icons.add,
                        aksi: () => _ubahJumlah(item, 1),
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Hapus item',
                        onPressed: () => _hapusItem(item),
                        icon: const Icon(
                          Icons.delete_outline,
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
    );
  }

  Widget _tombolJumlah({
    required IconData ikon,
    required VoidCallback aksi,
  }) {
    return InkWell(
      onTap: aksi,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppTheme.tint,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          ikon,
          size: 18,
          color: AppTheme.primary,
        ),
      ),
    );
  }

  Widget _buildRingkasan() {
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
            const Text(
              'Ringkasan Belanja',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total harga',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  _rupiah(_total),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  foregroundColor: Colors.white,
                ),
                onPressed: _items.isEmpty
                    ? null
                    : () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.checkout,
                        );
                      },
                icon: const Icon(Icons.receipt_long_outlined),
                label: const Text(
                  'Checkout',
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

  Widget _buildKosong() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                color: AppTheme.tint,
                borderRadius: BorderRadius.circular(52),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 48,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Keranjang masih kosong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yuk, pilih makanan dan minuman favoritmu!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => route.isFirst,
                );
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemKeranjang {
  final MenuKantin menu;
  int jumlah;

  _ItemKeranjang({
    required this.menu,
    required this.jumlah,
  });

  int get subtotal => menu.harga * jumlah;
}
