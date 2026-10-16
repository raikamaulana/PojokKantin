import 'package:flutter/material.dart';

import '../../core/route_names.dart';
import '../../shared/status_chip.dart';

class KantinMenungguPage extends StatelessWidget {
  const KantinMenungguPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final cs = t.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Pengajuan'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.hourglass_top_rounded,
                  size: 56,
                  color: cs.primary,
                ),
              ),
              const SizedBox(height: 24),
              const StatusChip(status: 'Menunggu Persetujuan'),
              const SizedBox(height: 12),
              Text(
                'Pengajuan Terkirim',
                style: t.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Pengajuan kantinmu sedang diperiksa admin. '
                'Dashboard Kantin akan terbuka setelah pengajuan disetujui.',
                textAlign: TextAlign.center,
                style: t.textTheme.bodyMedium
                    ?.copyWith(color: const Color(0xFF6B5F5F)),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                ),
                child: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
