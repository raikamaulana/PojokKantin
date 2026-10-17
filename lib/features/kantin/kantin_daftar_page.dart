import 'package:flutter/material.dart';

import '../../core/route_names.dart';
import '../../shared/app_text_field.dart';
import 'kantin_widgets.dart';

class KantinDaftarPage extends StatefulWidget {
  const KantinDaftarPage({super.key});

  @override
  State<KantinDaftarPage> createState() => _KantinDaftarPageState();
}

class _KantinDaftarPageState extends State<KantinDaftarPage> {
  final _nama = TextEditingController();
  final _deskripsi = TextEditingController();
  final _nomor = TextEditingController();
  final _buka = TextEditingController(text: '07.00');
  final _tutup = TextEditingController(text: '16.00');
  String _zona = 'Kiri';

  @override
  void dispose() {
    _nama.dispose();
    _deskripsi.dispose();
    _nomor.dispose();
    _buka.dispose();
    _tutup.dispose();
    super.dispose();
  }

  Future<void> _ambilJam(TextEditingController c) async {
    final jam = await pilihJam(context);
    if (jam != null) c.text = jam;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Jadi Penjual')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Kantin',
              style: t.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Isi data kantinmu. Pengajuan akan diperiksa admin.',
              style: t.textTheme.bodyMedium
                  ?.copyWith(color: const Color(0xFF6B5F5F)),
            ),
            const SizedBox(height: 20),
            AppTextField(
              label: 'Nama kantin',
              hint: 'Contoh: Kantin Bu Siti',
              controller: _nama,
              prefixIcon: const Icon(Icons.storefront_outlined),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Deskripsi',
              hint: 'Ceritakan singkat tentang kantinmu',
              controller: _deskripsi,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Text('Zona lokasi', style: t.textTheme.bodyMedium),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Kiri', label: Text('Zona Kiri')),
                  ButtonSegment(value: 'Kanan', label: Text('Zona Kanan')),
                ],
                selected: {_zona},
                onSelectionChanged: (s) => setState(() => _zona = s.first),
              ),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Nomor kantin',
              hint: 'Contoh: 4',
              controller: _nomor,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.pin_drop_outlined),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'Jam buka',
                    controller: _buka,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.schedule),
                      onPressed: () => _ambilJam(_buka),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    label: 'Jam tutup',
                    controller: _tutup,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.schedule),
                      onPressed: () => _ambilJam(_tutup),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Foto kantin', style: t.textTheme.bodyMedium),
            const SizedBox(height: 8),
            const KantinFotoBox(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                AppRoutes.kantinMenunggu,
              ),
              child: const Text('Kirim Pengajuan'),
            ),
          ],
        ),
      ),
    );
  }
}
