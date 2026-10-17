class AppUser {
  final String nama;
  final String email;
  final String username;
  final String nim;
  final String nomorHp;
  final String identitas;
  final String role;

  const AppUser({
    required this.nama,
    required this.email,
    required this.username,
    required this.nim,
    required this.nomorHp,
    required this.identitas,
    required this.role,
  });
}

class Kantin {
  final String id;
  final String nama;
  final String deskripsi;
  final String zona;
  final int nomor;
  final String jamBuka;
  final String jamTutup;
  final String status;
  final String imagePath;

  const Kantin({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.zona,
    required this.nomor,
    required this.jamBuka,
    required this.jamTutup,
    required this.status,
    required this.imagePath,
  });

  String get lokasi => 'Zona $zona, No. $nomor';
}

class MenuKantin {
  final String id;
  final String kantinId;
  final String nama;
  final String kategori;
  final String deskripsi;
  final int harga;
  final bool tersedia;
  final String imagePath;

  const MenuKantin({
    required this.id,
    required this.kantinId,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
    required this.harga,
    required this.tersedia,
    required this.imagePath,
  });
}

class ItemPesanan {
  final String menuId;
  final int jumlah;

  const ItemPesanan({
    required this.menuId,
    required this.jumlah,
  });
}

class Pesanan {
  final String id;
  final String pembeli;
  final String kantinId;
  final List<ItemPesanan> items;
  final String jamAmbil;
  final String metodePembayaran;
  final int total;
  final String status;

  const Pesanan({
    required this.id,
    required this.pembeli,
    required this.kantinId,
    required this.items,
    required this.jamAmbil,
    required this.metodePembayaran,
    required this.total,
    required this.status,
  });
}
