import 'package:flutter/material.dart';

import '../core/models.dart';
import '../core/utils.dart';

class MenuCard extends StatelessWidget {
  final MenuKantin menu;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MenuCard({
    super.key,
    required this.menu,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final showActions = onEdit != null || onDelete != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder gambar menu
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.restaurant_outlined,
                  color: colors.primary,
                  size: 28,
                ),
              ),

              const SizedBox(width: 12),

              // Informasi menu
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.nama,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      menu.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      formatRupiah(menu.harga),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (!menu.tersedia) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Habis',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Tombol khusus halaman Menu Saya
              if (showActions)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onEdit != null)
                      IconButton(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'Edit Menu',
                        color: colors.primary,
                      ),

                    if (onDelete != null)
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete_outline),
                        tooltip: 'Hapus Menu',
                        color: colors.error,
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}