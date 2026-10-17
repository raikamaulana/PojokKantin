import 'package:flutter/material.dart';

import '../core/models.dart';
import 'status_chip.dart';

class KantinCard extends StatelessWidget {
  final Kantin kantin;
  final VoidCallback? onTap;

  const KantinCard({
    super.key,
    required this.kantin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto kantin
            AspectRatio(
              aspectRatio: 16 / 9,
              child: kantin.imagePath.isNotEmpty
                  ? Image.asset(
                      kantin.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _imagePlaceholder(colorScheme);
                      },
                    )
                  : _imagePlaceholder(colorScheme),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kantin.nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          kantin.lokasi,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${kantin.jamBuka} - ${kantin.jamTutup}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  StatusChip(status: kantin.status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.primaryContainer,
      alignment: Alignment.center,
      child: Icon(
        Icons.storefront_outlined,
        size: 48,
        color: colorScheme.primary,
      ),
    );
  }
}