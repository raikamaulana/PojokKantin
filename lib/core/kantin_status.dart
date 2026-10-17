import 'models.dart';

class KantinStatus {
  static bool isOpen(Kantin kantin) {
    final status = kantin.status.trim().toLowerCase();
    return status == 'aktif' || status == 'buka';
  }

  static int? _menit(String jam) {
    final bagian = jam.split(RegExp(r'[:.]'));
    if (bagian.length != 2) return null;

    final hour = int.tryParse(bagian[0]);
    final minute = int.tryParse(bagian[1]);

    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      return null;
    }

    return hour * 60 + minute;
  }

  static bool isWithinOperationalHours(
    Kantin kantin, {
    DateTime? now,
  }) {
    final waktu = now ?? DateTime.now();
    final buka = _menit(kantin.jamBuka);
    final tutup = _menit(kantin.jamTutup);

    if (buka == null || tutup == null) return false;

    final sekarang = waktu.hour * 60 + waktu.minute;

    if (tutup < buka) {
      return sekarang >= buka || sekarang < tutup;
    }

    return sekarang >= buka && sekarang < tutup;
  }

  static bool isOutsideOperationalHours(
    Kantin kantin, {
    DateTime? now,
  }) {
    return isOpen(kantin) &&
        !isWithinOperationalHours(kantin, now: now);
  }

  static String badgeLabel(Kantin kantin) {
    if (!isOpen(kantin)) return 'Tutup';

    return isOutsideOperationalHours(kantin)
        ? 'Buka (buka di luar operasional)'
        : 'Buka';
  }
}