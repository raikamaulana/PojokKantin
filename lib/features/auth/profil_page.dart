import 'package:flutter/material.dart';

import '../../core/route_names.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 55,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Rina Maharani',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              '2410631170100@student.unsika.ac.id',
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.badge_outlined),
                      title: Text('NIM'),
                      subtitle: Text('2410631170100'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.school_outlined),
                      title: Text('Status'),
                      subtitle: Text('Mahasiswa'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profil'),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.profilEdit);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
