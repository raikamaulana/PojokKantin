import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  final String? description;

  const PlaceholderPage({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.construction_outlined,
                size: 64,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 16),

              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 8),

              Text(
                description ??
                    'Halaman ini sedang dalam tahap pengembangan.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 24),

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.maybePop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}