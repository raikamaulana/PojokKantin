import 'package:flutter/material.dart';

// Mengubah angka menjadi format mata uang Rupiah
String formatRupiah(int nominal) {
  final angka = nominal.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < angka.length; i++) {
    final sisaDigit = angka.length - i;

    buffer.write(angka[i]);

    if (sisaDigit > 1 && sisaDigit % 3 == 1) {
      buffer.write('.');
    }
  }

  return 'Rp ${buffer.toString()}';
}

// Menampilkan notifikasi singkat di bawah layar
void showSnack(BuildContext context, String pesan) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
}