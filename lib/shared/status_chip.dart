import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final normalized = status.toLowerCase().trim();

    Color backgroundColor;
    Color textColor;

    switch (normalized) {
      case 'selesai':
      case 'siap diambil':
      case 'aktif':
      case 'disetujui':
        backgroundColor = const Color(0xFFE7F5EA);
        textColor = const Color(0xFF247A3D);
        break;

      case 'diproses':
      case 'menunggu':
      case 'menunggu persetujuan':
        backgroundColor = const Color(0xFFFFF3D6);
        textColor = const Color(0xFF946200);
        break;

      case 'dibatalkan':
      case 'ditolak':
      case 'habis':
        backgroundColor = const Color(0xFFFCE8E8);
        textColor = const Color(0xFFB42318);
        break;

      default:
        backgroundColor = const Color(0xFFF1F1F1);
        textColor = const Color(0xFF616161);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}