import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/route_names.dart';
import '../../shared/app_drawer.dart';
import '../../shared/status_chip.dart';

class AdminPengajuanPage extends StatefulWidget {
  const AdminPengajuanPage({super.key});

  @override
  State<AdminPengajuanPage> createState() => _AdminPengajuanPageState();
}

class _AdminPengajuanPageState extends State<AdminPengajuanPage> {
  // Salinan lokal supaya status bisa berubah setelah admin memutuskan.
  final List<Kantin> _items = List.of(DummyData.pengajuanKantin);

  Future<void> _bukaDetail(int index) async {
    final hasil = await Navigator.pushNamed<String>(
      context,
      AppRoutes.adminPengajuanDetail,
      arguments: _items[index],
    );
    if (hasil == null || !mounted) return;
    final k = _items[index];
    setState(() {
      _items[index] = Kantin(
        id: k.id,
        nama: k.nama,
        deskripsi: k.deskripsi,
        zona: k.zona,
        nomor: k.nomor,
        jamBuka: k.jamBuka,
        jamTutup: k.jamTutup,
        imagePath: k.imagePath,
        status: hasil,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    final u = DummyData.currentUser;
    final admin = AppUser(
      nama: u.nama,
      email: u.email,
      username: u.username,
      nim: u.nim,
      nomorHp: u.nomorHp,
      identitas: u.identitas,
      role: 'admin',
    );

    final menunggu = _items.where((k) => k.status == 'Menunggu').length;

    return Scaffold(
      appBar: AppBar(title: const Text('Cek Pengajuan Kantin')),
      drawer: AppDrawer(user: admin),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          if (i == 0) {
            return Text(
              '$menunggu pengajuan menunggu persetujuan',
              style: t.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF6B5F5F),
              ),
            );
          }
          final k = _items[i - 1];
          return Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              leading: CircleAvatar(
                backgroundColor: t.colorScheme.primaryContainer,
                child: Icon(Icons.storefront, color: t.colorScheme.primary),
              ),
              title: Text(
                k.nama,
                overflow: TextOverflow.ellipsis,
                style: t.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(k.lokasi),
              trailing: StatusChip(status: k.status),
              onTap: () => _bukaDetail(i - 1),
            ),
          );
        },
      ),
    );
  }
}
