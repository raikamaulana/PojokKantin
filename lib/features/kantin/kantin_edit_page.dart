import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/route_names.dart';
import '../../core/utils.dart';
import '../../core/theme.dart';
import '../../shared/app_text_field.dart';
import 'kantin_widgets.dart';

class KantinEditPage extends StatefulWidget {
  const KantinEditPage({super.key});

  @override
  State<KantinEditPage> createState() => _KantinEditPageState();
}

class _KantinEditPageState extends State<KantinEditPage> {
  late final TextEditingController _nama;
  late final TextEditingController _deskripsi;
  late final TextEditingController _nomor;
  late final TextEditingController _buka;
  late final TextEditingController _tutup;
  late String _zona;

  @override
  void initState() {
    super.initState();
    final k = DummyData.kantin.first;
    _nama = TextEditingController(text: k.nama);
    _deskripsi = TextEditingController(text: k.deskripsi);
    _nomor = TextEditingController(text: '${k.nomor}');
    _buka = TextEditingController(text: k.jamBuka);
    _tutup = TextEditingController(text: k.jamTutup);
    _zona = k.zona;
  }

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

  void _konfirmasiHapus() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Kantin?'),
        content: const Text(
          'Kantin beserta menunya akan dihapus. '
          'Tindakan ini tidak bisa dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              showSnack(context, 'Kantin berhasil dihapus');
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final error = t.colorScheme.error;
    final kantin = DummyData.kantin.first;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 68,
        title: const Text(
          'Edit Kantin',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                label: 'Nama kantin',
                controller: _nama,
                prefixIcon: const Icon(Icons.storefront_outlined),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Deskripsi',
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
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  kantin.imagePath,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 160,
                      color: AppTheme.tint,
                      child: const Icon(
                        Icons.storefront_outlined,
                        size: 56,
                        color: AppTheme.primary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showSnack(context, 'Perubahan berhasil disimpan');
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Simpan Perubahan'),
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
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: _konfirmasiHapus,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Hapus Kantin'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: error,
                    side: BorderSide(color: error),
                    backgroundColor: Colors.white,
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
