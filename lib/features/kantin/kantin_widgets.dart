import 'package:flutter/material.dart';

/// Kotak placeholder foto kantin (tampilan saja).
class KantinFotoBox extends StatelessWidget {
  final String label;
  final double height;

  const KantinFotoBox({
    super.key,
    this.label = 'Unggah foto kantin',
    this.height = 140,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outline),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo_outlined, color: cs.primary, size: 32),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: cs.primary)),
        ],
      ),
    );
  }
}

/// Baris ikon + label kecil + nilai, untuk halaman profil/detail.
class KantinInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const KantinInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: t.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: t.textTheme.bodySmall
                      ?.copyWith(color: const Color(0xFF6B5F5F)),
                ),
                const SizedBox(height: 2),
                Text(value, style: t.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pilih jam lewat time picker, hasilnya format "07.00".
Future<String?> pilihJam(BuildContext context) async {
  final t = await showTimePicker(
    context: context,
    initialTime: const TimeOfDay(hour: 8, minute: 0),
  );
  if (t == null) return null;
  final h = t.hour.toString().padLeft(2, '0');
  final m = t.minute.toString().padLeft(2, '0');
  return '$h.$m';
}
