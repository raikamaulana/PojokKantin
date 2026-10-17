import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/route_names.dart';
import '../../shared/status_chip.dart';
import 'kantin_widgets.dart';

class KantinProfilPage extends StatelessWidget {
  const KantinProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final kantin = DummyData.kantin.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Profil Kantin')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KantinFotoBox(label: 'Foto kantin', height: 160),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    kantin.nama,
                    style: t.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                StatusChip(status: kantin.status),
              ],
            ),
            const SizedBox(height: 12),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    KantinInfoRow(
                      icon: Icons.notes,
                      label: 'Deskripsi',
                      value: kantin.deskripsi,
                    ),
                    const Divider(),
                    KantinInfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Lokasi',
                      value: kantin.lokasi,
                    ),
                    const Divider(),
                    KantinInfoRow(
                      icon: Icons.schedule,
                      label: 'Jam operasional',
                      value: '${kantin.jamBuka} - ${kantin.jamTutup}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.kantinProfilEdit),
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit Kantin'),
            ),
          ],
        ),
      ),
    );
  }
}
