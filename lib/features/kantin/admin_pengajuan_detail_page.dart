import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/utils.dart';
import '../../shared/status_chip.dart';
import 'kantin_widgets.dart';

class AdminPengajuanDetailPage extends StatelessWidget {
  const AdminPengajuanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final error = t.colorScheme.error;

    // Data dikirim dari daftar pengajuan lewat arguments.
    final arg = ModalRoute.of(context)?.settings.arguments;
    final Kantin k = arg is Kantin ? arg : DummyData.pengajuanKantin.first;
    final sudahDiputuskan = k.status != 'Menunggu';

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengajuan')),
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
                    k.nama,
                    style: t.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                StatusChip(status: k.status),
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
                      value: k.deskripsi,
                    ),
                    const Divider(),
                    KantinInfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Lokasi',
                      value: k.lokasi,
                    ),
                    const Divider(),
                    KantinInfoRow(
                      icon: Icons.schedule,
                      label: 'Jam operasional',
                      value: '${k.jamBuka} - ${k.jamTutup}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (!sudahDiputuskan)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: error,
                        side: BorderSide(color: error),
                      ),
                      onPressed: () {
                        showSnack(context, 'Pengajuan ditolak');
                        Navigator.pop(context, 'Ditolak');
                      },
                      child: const Text('Tolak'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showSnack(context, 'Pengajuan disetujui');
                        Navigator.pop(context, 'Disetujui');
                      },
                      child: const Text('Setujui'),
                    ),
                  ),
                ],
              )
            else
              Center(
                child: Text(
                  'Pengajuan ini sudah ${k.status.toLowerCase()}.',
                  style: t.textTheme.bodyMedium
                      ?.copyWith(color: const Color(0xFF6B5F5F)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
