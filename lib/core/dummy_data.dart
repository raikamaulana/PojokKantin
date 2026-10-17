
import 'models.dart';

class DummyData {
  DummyData._();

  // Pengguna yang sedang login
  static const AppUser currentUser = AppUser(
    nama: 'Puan Maharani',
    email: '2410631170200@student.unsika.ac.id',
    username: 'puan_maharani',
    nim: '2410631170200',
    nomorHp: '081234567890',
    identitas: 'Mahasiswa',
    role: 'mahasiswa',
  );

  // Data kantin
  static const List<Kantin> kantin = [
    Kantin(
      id: 'K001',
      nama: 'Kantin Bu Siti',
      deskripsi: 'Aneka makanan rumahan dan minuman segar.',
      zona: 'Kiri',
      nomor: 1,
      jamBuka: '07.00',
      jamTutup: '16.00',
      status: 'Aktif',
      imagePath: 'assets/images/kantin/kantin-kedai-husna.jpeg',
    ),
    Kantin(
      id: 'K002',
      nama: 'Kedai Kopi Kampus',
      deskripsi: 'Kopi, minuman dingin, dan camilan.',
      zona: 'Kanan',
      nomor: 2,
      jamBuka: '08.00',
      jamTutup: '17.00',
      status: 'Aktif',
      imagePath: 'assets/images/kantin/kantin-mama-iqbal.jpeg',
    ),
    Kantin(
      id: 'K003',
      nama: 'Nasduk Pade',
      deskripsi: 'Pilihan makanan praktis untuk mahasiswa.',
      zona: 'Kiri',
      nomor: 3,
      jamBuka: '07.00',
      jamTutup: '16.00',
      status: 'Aktif',
      imagePath: 'assets/images/kantin/kantin-f-two.jpeg',
    ),
  ];

  // Data menu makanan dan minuman
  static const List<MenuKantin> menu = [
    MenuKantin(
      id: 'M001',
      kantinId: 'K001',
      nama: 'Nasi Ayam Geprek',
      kategori: 'Makanan',
      deskripsi: 'Nasi hangat dengan ayam geprek dan sambal.',
      harga: 15000,
      tersedia: true,
      imagePath: 'assets/images/kantin/kantin-bunda.jpeg',
    ),
    MenuKantin(
      id: 'M002',
      kantinId: 'K001',
      nama: 'Nasi Rames',
      kategori: 'Makanan',
      deskripsi: 'Nasi dengan aneka lauk dan sayuran.',
      harga: 12000,
      tersedia: true,
      imagePath: 'assets/images/kantin/kantin-bunda.jpeg',
    ),
    MenuKantin(
      id: 'M003',
      kantinId: 'K001',
      nama: 'Es Teh Manis',
      kategori: 'Minuman',
      deskripsi: 'Teh manis dingin yang menyegarkan.',
      harga: 4000,
      tersedia: true,
      imagePath: 'assets/images/kantin/kantin-bunda.jpeg',
    ),
    MenuKantin(
      id: 'M004',
      kantinId: 'K001',
      nama: 'Cireng 2K',
      kategori: 'Snack',
      deskripsi: 'Cireng murah enak dan renyah.',
      harga: 2000,
      tersedia: false,
      imagePath: 'assets/images/kantin/kantin-bunda.jpeg',
    ),
    MenuKantin(
      id: 'M005',
      kantinId: 'K003',
      nama: 'Mie Ayam',
      kategori: 'Makanan',
      deskripsi: 'Mie ayam murah enak.',
      harga: 10000,
      tersedia: false,
      imagePath: 'assets/images/kantin/kantin-bunda.jpeg',
    ),
  ];

  // Data pesanan
  static const List<Pesanan> pesanan = [
    Pesanan(
      id: 'ORD-001',
      pembeli: 'Siti Maharani',
      kantinId: 'K001',
      items: [
        ItemPesanan(menuId: 'M001', jumlah: 1),
        ItemPesanan(menuId: 'M003', jumlah: 1),
      ],
      jamAmbil: '12.15',
      metodePembayaran: 'Tunai di kantin',
      total: 19000,
      status: 'Diproses',
    ),
    Pesanan(
      id: 'ORD-002',
      pembeli: 'Dandy Maharaja',
      kantinId: 'K001',
      items: [
        ItemPesanan(menuId: 'M002', jumlah: 1),
      ],
      jamAmbil: '13.00',
      metodePembayaran: 'QRIS',
      total: 12000,
      status: 'Siap diambil',
    ),
    Pesanan(
      id: 'ORD-003',
      pembeli: 'Rizky Dermawan',
      kantinId: 'K001',
      items: [
        ItemPesanan(menuId: 'M001', jumlah: 3),
        ItemPesanan(menuId: 'M003', jumlah: 2),
      ],
      jamAmbil: '10.30',
      metodePembayaran: 'QRIS',
      total: 53000,
      status: 'Selesai',
    ),
    Pesanan(
      id: 'ORD-004',
      pembeli: 'Akmal Fauzan',
      kantinId: 'K001',
      items: [
        ItemPesanan(menuId: 'M001', jumlah: 2),
        ItemPesanan(menuId: 'M002', jumlah: 1),
      ],
      jamAmbil: '11.45',
      metodePembayaran: 'Tunai di kantin',
      total: 42000,
      status: 'Selesai',
    ),
    Pesanan(
      id: 'ORD-005',
      pembeli: 'Jemiansyah',
      kantinId: 'K001',
      items: [
        ItemPesanan(menuId: 'M003', jumlah: 4),
        ItemPesanan(menuId: 'M004', jumlah: 2),
      ],
      jamAmbil: '12.00',
      metodePembayaran: 'QRIS',
      total: 20000,
      status: 'Selesai',
    ),
  ];

  // Data pengajuan kantin untuk halaman admin
  static const List<Kantin> pengajuanKantin = [
    Kantin(
      id: 'K004',
      nama: 'Kantin Sehat Ibu Dewi',
      deskripsi: 'Menu sehat dan makanan rumahan.',
      zona: 'Kanan',
      nomor: 4,
      jamBuka: '07.00',
      jamTutup: '15.00',
      status: 'Menunggu',
      imagePath: 'assets/images/kantin/kantin-bunda.jpeg',
    ),
    Kantin(
      id: 'K005',
      nama: 'Bakso Pak Joko',
      deskripsi: 'Bakso dan mie ayam.',
      zona: 'Kiri',
      nomor: 5,
      jamBuka: '09.00',
      jamTutup: '17.00',
      status: 'Menunggu',
      imagePath: 'assets/images/kantin/kantin-mang-ono.jpeg',
    ),
  ];

  // Helper untuk mengambil data berdasarkan ID
  static Kantin? cariKantin(String id) {
    for (final item in kantin) {
      if (item.id == id) return item;
    }
    return null;
  }

  static MenuKantin? cariMenu(String id) {
    for (final item in menu) {
      if (item.id == id) return item;
    }
    return null;
  }

  static List<MenuKantin> menuDariKantin(String kantinId) {
    return menu.where((item) => item.kantinId == kantinId).toList();
  }
}
