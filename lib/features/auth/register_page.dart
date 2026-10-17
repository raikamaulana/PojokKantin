import 'package:flutter/material.dart';

import '../../core/route_names.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              Icon(
                Icons.school_rounded,
                size: 90,
                color: theme.colorScheme.primary,
              ),

              const SizedBox(height: 24),

              Text(
                'Pojok Kantin',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                '-- UNSIKA --',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'Daftar menggunakan akun UNSIKA.\n\n'
                'Halaman ini hanya simulasi tampilan dan tidak terhubung dengan sistem SSO UNSIKA.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.account_circle_outlined),
                  label: const Text('Masuk dengan Akun UNSIKA'),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.registerDataDiri);
                  },
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali ke Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
