import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/kantin_status.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late final List<_ItemCheckout> _items;

  String? _jamAmbil;
  String _metodePembayaran = 'Tunai di kantin';

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
      _ItemCheckout(menu: DummyData.cariMenu('M001')!, jumlah: 1),
      _ItemCheckout(menu: DummyData.cariMenu('M003')!, jumlah: 1),
    ];
  }

  int get _total => _items.fold(0, (total, item) => total + item.subtotal);

  Kantin? get _kantin =>
      _items.isEmpty ? null : DummyData.cariKantin(_items.first.menu.kantinId);
  
  TimeOfDay? _parseJam(String value) {
    final bagian = value.split(RegExp(r'[:.]'));

    if (bagian.length != 2) return null;

    final jam = int.tryParse(bagian[0]);
    final menit = int.tryParse(bagian[1]);

    if (jam == null || menit == null) return null;
    if (jam < 0 || jam > 23 || menit < 0 || menit > 59) {
      return null;
    }

    return TimeOfDay(hour: jam, minute: menit);
  }

  DateTime _waktuHariIni(DateTime sekarang, TimeOfDay jam) {
    return DateTime(
      sekarang.year,
      sekarang.month,
      sekarang.day,
      jam.hour,
      jam.minute,
    );
  }

  bool get _kantinBuka {
    final kantin = _kantin;
    return kantin != null && KantinStatus.isOpen(kantin);
  }

  bool get _bukaDiLuarOperasional {
    final kantin = _kantin;
    return kantin != null &&
        KantinStatus.isOutsideOperationalHours(kantin);
  }

  String? _validasiJamPengambilan(TimeOfDay pilihan) {
    final kantin = _kantin;

    if (kantin == null || !_kantinBuka) {
      return 'Kantin sedang tutup. Pesanan tidak dapat dibuat.';
    }

    final sekarang = DateTime.now();
    final waktuDipilih = _waktuHariIni(sekarang, pilihan);

    if (!waktuDipilih.isAfter(sekarang)) {
      return 'Jam pengambilan harus lebih dari waktu sekarang.';
    }

    if (_bukaDiLuarOperasional) {
      final batas = sekarang.add(const Duration(minutes: 10));

      if (waktuDipilih.isAfter(batas)) {
        return 'Di luar jam operasional, pengambilan maksimal 10 menit dari sekarang.';
      }
    } else {
      final tutup = _parseJam(kantin.jamTutup);

      if (tutup == null) {
        return 'Jam tutup kantin tidak valid.';
      }

      var batasTutup = _waktuHariIni(sekarang, tutup);
      final buka = _parseJam(kantin.jamBuka);

      // Untuk operasional yang melewati tengah malam.
      if (buka != null) {
        final waktuBuka = _waktuHariIni(sekarang, buka);

        if (batasTutup.isBefore(waktuBuka) &&
            !sekarang.isBefore(waktuBuka)) {
          batasTutup = batasTutup.add(const Duration(days: 1));
        }
      }

      if (waktuDipilih.isAfter(batasTutup)) {
        return 'Jam pengambilan tidak boleh melewati jam tutup kantin (${kantin.jamTutup}).';
      }
    }

    return null;
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(pesan)),
      );
  }

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
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 68,
        title: const Text(
          'Checkout',
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
        child: _items.isEmpty
            ? const Center(child: Text('Tidak ada item untuk checkout.'))
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
      ) 
    );
  }

  Widget _buildBagianJudul({required IconData ikon, required String judul}) {
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.asset(
                          item.menu.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.restaurant_outlined,
                            color: AppTheme.primary,
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
                  style: const TextStyle(fontWeight: FontWeight.w600),
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
    final diLuarOperasional = _bukaDiLuarOperasional;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 76,
                height: 76,
                child: kantin != null && kantin.imagePath.isNotEmpty
                    ? Image.asset(
                        kantin.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.storefront_outlined,
                          color: AppTheme.primary,
                          size: 30,
                        ),
                      )
                    : const Icon(
                        Icons.storefront_outlined,
                        color: AppTheme.primary,
                        size: 30,
                      ),
              ),
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
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _kantinBuka
                          ? const Color(0xFFE7F5E9)
                          : AppTheme.tint,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      !_kantinBuka
                          ? 'Tutup'
                          : diLuarOperasional
                              ? 'Buka (buka di luar operasional)'
                              : 'Buka',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _kantinBuka
                            ? const Color(0xFF237A3B)
                            : AppTheme.primary,
                      ),
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

  Future<void> _pilihJamPengambilan() async {
    if (!_kantinBuka) {
      _tampilkanPesan('Kantin sedang tutup.');
      return;
    }

    final sekarang = DateTime.now();

    final pilihan = await showTimePicker(
      context: context,
      initialTime: _jamAmbil != null
          ? _parseJam(_jamAmbil!) ??
              TimeOfDay.fromDateTime(
                sekarang.add(const Duration(minutes: 1)),
              )
          : TimeOfDay.fromDateTime(
              sekarang.add(const Duration(minutes: 1)),
            ),
      initialEntryMode: TimePickerEntryMode.inputOnly,
      helpText: 'Masukkan Jam Pengambilan',
      hourLabelText: 'Jam',
      minuteLabelText: 'Menit',
      confirmText: 'Simpan',
      cancelText: 'Batal',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );

    if (!mounted || pilihan == null) return;

    final error = _validasiJamPengambilan(pilihan);

    if (error != null) {
      _tampilkanPesan(error);
      return;
    }

    setState(() {
      _jamAmbil =
          '${pilihan.hour.toString().padLeft(2, '0')}.'
          '${pilihan.minute.toString().padLeft(2, '0')}';
    });
  }

  Widget _buildPilihanJam() {
    final kantin = _kantin;
    final diLuarOperasional = _bukaDiLuarOperasional;

    return Card(
      color: AppTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: _kantinBuka ? _pilihJamPengambilan : null,
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: AppTheme.primary,
                    size: 26,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      _jamAmbil ?? 'Masukkan jam pengambilan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _jamAmbil == null
                            ? AppTheme.textSecondary
                            : AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.edit_calendar_outlined,
                    color: AppTheme.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              !_kantinBuka
                  ? 'Kantin sedang tutup.'
                  : diLuarOperasional
                      ? 'Kantin buka di luar operasional. Pengambilan maksimal 10 menit dari sekarang.'
                      : 'Pilih jam setelah waktu sekarang, maksimal pukul ${kantin?.jamTutup ?? '-'}.',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPilihanPembayaran() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: _pilihanPembayaran.map((metode) {
            final ikon = switch (metode) {
              'Tunai di kantin' => Icons.payments_outlined,
              'QRIS' => Icons.qr_code_2_outlined,
              _ => Icons.account_balance_wallet_outlined,
            };

            return RadioListTile<String>(
              value: metode,
              groupValue: _metodePembayaran,
              onChanged: (value) {
                if (value == null) return;
                setState(() => _metodePembayaran = value);
              },
              activeColor: AppTheme.primary,
              contentPadding: EdgeInsets.zero,
              dense: true,
              secondary: Icon(ikon, color: AppTheme.primary),
              title: Text(metode, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRingkasanTotal() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.divider)),
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
                  style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
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
                onPressed: _items.isEmpty || !_kantinBuka
                    ? null
                    : _buatPesanan,
                child: const Text(
                  'Buat Pesanan',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _buatPesanan() async {
    if (!_kantinBuka) {
      _tampilkanPesan('Kantin sedang tutup.');
      return;
    }

    if (_jamAmbil == null) {
      _tampilkanPesan('Silakan masukkan jam pengambilan terlebih dahulu.');
      return;
    }

    final pilihan = _parseJam(_jamAmbil!);

    if (pilihan == null) {
      _tampilkanPesan('Format jam pengambilan tidak valid.');
      return;
    }

    final error = _validasiJamPengambilan(pilihan);

    if (error != null) {
      _tampilkanPesan(error);
      return;
    }

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

  const _ItemCheckout({required this.menu, required this.jumlah});

  int get subtotal => menu.harga * jumlah;
}
