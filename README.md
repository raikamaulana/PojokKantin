# Pojok Kantin — Pre-Order Kantin Belakang UNSIKA

> Nama aplikasi final: **Pojok Kantin**. Identitas kampus ditampilkan sebagai **-- UNSIKA --** di bawah nama aplikasi.

PojokKantin adalah aplikasi mobile berbasis Flutter yang mempertemukan mahasiswa dengan kantin belakang kampus UNSIKA. Mahasiswa bisa melihat daftar kantin dan menu, memesan makanan lebih dulu, lalu mengambilnya sesuai jam yang dipilih. Mahasiswa juga bisa mendaftarkan kantinnya sendiri sebagai penjual, yang kemudian diperiksa admin.

## Identitas aplikasi

Tampilan branding pada Splash, Onboarding, Login, dan Register menggunakan susunan rata tengah berikut:

```text
Pojok Kantin
-- UNSIKA --
```

Tulisan **Pojok Kantin** lebih besar dan tebal, sedangkan **-- UNSIKA --** lebih kecil di bawahnya. Gunakan warna dan aturan visual dari `docs/design.md`.

**Proyek ini hanya berisi UI dan wireframe.** Tidak ada database, tidak ada data asli, dan tidak ada proses di balik layar. Semua data adalah dummy statis, jadi sisanya aman dan tidak perlu dipusingkan.

## 1. Tim

| Anggota | Entitas | Folder milik |
|---|---|---|
| Ahmad | Pembeli (target) | `lib/features/auth/` |
| Dandy | Kantin + Admin (pengelola) | `lib/features/kantin/` |
| Raika (PM) | Menu (kunci) | `lib/features/menu/` |
| Sukma | Pesanan (transaksi) | `lib/features/pesanan/` |

Setiap anggota mengerjakan UI satu proses CRUD:

| Entitas | Di aplikasi | CRUD |
|---|---|---|
| Kunci | Menu makanan/minuman | Tambah, lihat, edit, hapus menu |
| Pengelola | Kantin/penjual (diverifikasi admin) | Daftar, lihat, edit, hapus kantin |
| Target | Pembeli (mahasiswa) | Daftar akun, lihat, edit, hapus profil |
| Transaksi | Pesanan | Buat (checkout), lihat riwayat, ubah status, batalkan |

## 2. Alur aplikasi

```
Splash → Onboarding → Login / Register
Login   : tombol "Masuk" langsung ke Beranda (statis, tanpa validasi)
Register: "Masuk dengan Akun Unsika" (SIMULASI tampilan) → form data tambahan → Beranda
Beranda → pilih kantin → daftar menu → detail menu → keranjang → checkout → status pesanan
Daftar Jadi Penjual → form daftar kantin → "Menunggu Persetujuan" → kembali ke Beranda
```

**Navigasi pembeli (final berdasarkan Google Stitch):**
- **AppBar Beranda:** ikon hamburger di kiri, branding dua baris "Pojok Kantin" / "-- UNSIKA --" di tengah; tanpa ikon keranjang atau profil di kanan. Tidak perlu judul "Beranda" tambahan di konten.
- **Bottom Navigation:** Beranda (`/home`), Pesanan (`/pesanan`), Keranjang (`/keranjang`), Profil (`/profil`). Item aktif diberi warna Primary.
- **Drawer:** header marun dengan avatar, nama, dan email; menu "Profil Saya" langsung di bawah header; kelompok berlabel LAYANAN KANTIN → Daftar Jadi Penjual; PANEL PENJUAL → Dashboard Kantin; ADMIN → Cek Pengajuan Kantin; AKUN → Keluar Akun. Gunakan jarak antargrup 12–16px, label ke menu 6–8px, tanpa garis pemisah antarkategori.
- **Halaman lain:** AppBar menggunakan judul sesuai halaman (mis. Keranjang, Checkout, Detail Menu). Hindari duplikasi ikon keranjang/profil yang sudah tersedia di navigasi bawah.

**Hak akses disimulasikan dengan role dummy** (`mahasiswa`, `penjual`, `admin`) tanpa autentikasi/backend. Mockup Stitch drawer lengkap menampilkan seluruh kategori sebagai referensi visual, tetapi aplikasi Flutter hanya menampilkan menu yang sesuai role: mahasiswa → Profil Saya, Daftar Jadi Penjual, Keluar Akun; penjual → Profil Saya, Dashboard Kantin, Keluar Akun; admin → Profil Saya, Cek Pengajuan Kantin, Keluar Akun. Tombol/demo pergantian role bila dibutuhkan hanya untuk presentasi UI, bukan sistem hak akses sungguhan.

**Status identitas dan akses di header drawer:** tampilkan badge terpisah di bawah email, misalnya `Mahasiswa` + `Penjual`, `Staf UNSIKA` + `Penjual`, `Penjual` (akun umum yang telah disetujui), `Pengguna Umum`, atau `Admin` saja. Identitas Mahasiswa/Staf/Pengguna Umum tidak memberi privilege pembelian khusus. Semua akun biasa dapat membeli dan mengajukan kantin setelah login; status `Penjual` muncul hanya setelah persetujuan admin. `Admin` tidak boleh merangkap `Penjual`. Untuk tugas UI-only, status dan proses persetujuan cukup disimulasikan lewat dummy data; domain email tidak dianggap bukti verifikasi sungguhan.

Dashboard Kantin berisi: Menu Saya (CRUD), Pesanan Masuk, Profil Kantin. Nama user, nama kantin, dan menu tetap diambil dari data dummy.

**Format lokasi kantin:** gunakan `Zona Kiri, No. 1` atau `Zona Kanan, No. 2` pada kartu kantin, profil kantin, pengajuan, dan informasi pengambilan pesanan. Zona Kiri/Kanan mengikuti dua deretan warung dari arah jalan masuk kantin belakang UNSIKA; nomor dihitung dari awal masing-masing deretan. Nomor tersebut adalah **usulan penomoran Pojok Kantin untuk simulasi UI**, bukan nomor resmi yang sudah terpasang di lokasi. Pada form penjual, lokasi terdiri dari pilihan Zona Kiri/Kanan dan nomor kantin. Contoh dummy: Kantin Bu Siti — Zona Kiri, No. 1; Kedai Kopi Kampus — Zona Kanan, No. 2; Warung Teknik — Zona Kiri, No. 3.

**Acuan data profil dummy:** Rina Maharani, email `2410631170100@student.unsika.ac.id`, NIM `2410631170100` (contoh UI, bukan identitas akun asli).

## 3. Daftar halaman dan pemilik

### Ahmad — `features/auth/`
| Halaman | Route |
|---|---|
| Splash | `/splash` |
| Onboarding | `/onboarding` |
| Login | `/login` |
| Register (akun Unsika) | `/register` |
| Form data diri | `/register/data-diri` |
| Profil | `/profil` |
| Edit profil (+ dialog hapus akun) | `/profil/edit` |

### Dandy — `features/kantin/`
| Halaman | Route |
|---|---|
| Form daftar kantin | `/kantin/daftar` |
| Status menunggu persetujuan | `/kantin/menunggu` |
| Dashboard kantin | `/kantin/dashboard` |
| Profil kantin | `/kantin/profil` |
| Edit kantin (+ dialog hapus kantin) | `/kantin/profil/edit` |
| Admin: daftar pengajuan | `/admin/pengajuan` |
| Admin: detail pengajuan (setujui/tolak) | `/admin/pengajuan/detail` |

### Raika — `features/menu/`
| Halaman | Route |
|---|---|
| Beranda pembeli (daftar kantin) | `/home` |
| Daftar menu per kantin | `/kantin/menu-list` |
| Detail menu | `/menu/detail` |
| Menu saya (penjual) | `/kantin/menu` |
| Tambah menu | `/kantin/menu/tambah` |
| Edit menu (+ dialog hapus) | `/kantin/menu/edit` |

### Sukma — `features/pesanan/`
| Halaman | Route |
|---|---|
| Keranjang | `/keranjang` |
| Checkout (jam ambil, metode bayar statis) | `/checkout` |
| Riwayat pesanan | `/pesanan` |
| Detail pesanan (+ batalkan) | `/pesanan/detail` |
| Pesanan masuk (penjual) | `/kantin/pesanan` |
| Detail pesanan masuk (ubah status) | `/kantin/pesanan/detail` |

Total 26 halaman. Jika waktu mepet, potong dulu: onboarding jadi 1 halaman, metode pembayaran jadi pilihan statis, admin tetap 2 halaman.

## 4. Setup (dilakukan PM sekali, lalu anggota tinggal clone)

```bash
flutter create pojokkantin          # buat proyek Flutter baru
cd pojokkantin
# 1. hapus file test bawaan (merujuk ke MyApp, akan error)
rm test/widget_test.dart
# 2. hapus lib/main.dart bawaan, lalu salin folder lib/ dan docs/ dari kerangka ini
# 3. salin README.md dan folder assets/ ke root
# 4. buka pubspec.yaml, pada bagian `flutter:` tambahkan (sejajar dengan uses-material-design):
#      assets:
#        - assets/images/
flutter pub get
flutter analyze                  # harus tanpa error
flutter run                      # harus tampil halaman placeholder
```

**Semua anggota:** jalankan `flutter doctor` dan `flutter --version`, pastikan aplikasi bisa dijalankan di laptop masing-masing **hari ini**.

## 5. Struktur folder

```
lib/
  main.dart
  core/                   ← kerangka, hanya diubah PM
    route_names.dart      ← nama semua route (DIKUNCI)
    routes.dart           ← menggabungkan route semua fitur
    theme.dart
    models.dart           ← User, Kantin, Menu, Pesanan
    dummy_data.dart       ← SATU sumber data dummy
    utils.dart            ← formatRupiah(), showSnack()
  shared/                 ← widget bersama, hanya diubah PM
    app_drawer.dart       ← drawer bersama, menu berdasarkan role dummy
    app_bottom_nav.dart   ← Bottom Navigation pembeli
    placeholder_page.dart
    menu_card.dart
    kantin_card.dart
    status_chip.dart
    app_text_field.dart
  features/
    auth/      auth_routes.dart       ← Ahmad
    kantin/    kantin_routes.dart     ← Dandy
    menu/      menu_routes.dart       ← Raika
    pesanan/   pesanan_routes.dart    ← Sukma
assets/
  images/                 ← gambar lokal, hanya ditambah PM
docs/
  design.md               ← Design System (diimpor ke Google Stitch)
  stitch_prompts.md       ← prompt Stitch untuk 26 halaman
  screenshots/            ← screenshot desain dan hasil aplikasi
```

## 6. Cara membuat halaman (ikuti urutan ini)

1. Buat file halamanmu di folder fiturmu, mis. `lib/features/menu/menu_tambah_page.dart`.
2. Buka `<fitur>_routes.dart` di **foldermu sendiri**, ganti `PlaceholderPage(...)` pada route halamanmu dengan halaman barumu, dan tambahkan import-nya.
3. Jalankan `flutter run` dan buka halamanmu (bisa lewat tombol lompat di placeholder halaman lain).
4. Pindah halaman dengan `Navigator.pushNamed(context, AppRoutes.nama)`. **Jangan import halaman milik orang lain.**

Karena tiap orang hanya mengedit file `*_routes.dart` miliknya, tidak akan terjadi konflik merge di route.

## 7. Aturan kerja (penting)

1. **Hanya edit foldermu sendiri.** Perubahan di `core/` atau `shared/` diajukan ke PM di grup.
2. **Nama route dikunci** di `core/route_names.dart`. Butuh route baru? Minta ke PM.
3. **Data hanya dari `core/dummy_data.dart`.** Jangan mengetik nama user, nama kantin, menu, atau harga langsung di halaman, supaya data seragam di semua halaman. Butuh data baru? Minta PM menambahkannya ke `dummy_data.dart`.
4. **Hanya widget bawaan Flutter.** Tidak boleh menambah package di `pubspec.yaml`.
5. **Pakai widget dari `shared/`** (`MenuCard`, `KantinCard`, `StatusChip`, `AppTextField`, `AppDrawer`, `AppBottomNav`). Jangan buat ulang. Warna dan font ambil dari `Theme.of(context)`, jangan hardcode.
6. **Semua statis:** tidak ada validasi, tidak ada database, tidak ada API. Tombol Login/Simpan/Hapus cukup berpindah halaman atau menampilkan `showSnack(context, 'Menu berhasil ditambahkan')`.
7. Form tetap harus **tampil lengkap** (kolom input ada), karena itulah yang dinilai sebagai desain.
8. Pasang `AppDrawer` pada halaman yang memerlukan drawer dan `AppBottomNav` pada halaman utama pembeli. Pastikan tampilan menu mengikuti role dummy dari `core/dummy_data.dart`; jangan buat drawer/bottom nav versi masing-masing.

### Ikon dan gambar
- **Ikon: hanya `Icons.*` bawaan Flutter**, tanpa package. Bentuknya `Icons.shopping_cart_outlined`. Desain Stitch memakai ikon Material, jadi hampir semua namanya sama.
- Jika `Icons.xxx` tidak ditemukan (error "isn't defined"), pilih ikon terdekat yang ada, jangan menambah package. Tanyakan ke AI: "Ganti dengan ikon terdekat yang tersedia di Flutter Icons".
- **Tidak ada foto.** Tempat gambar memakai kotak warna `colorScheme.primaryContainer` dengan ikon di tengah (lihat `MenuCard`). Jangan memakai `Image.network` atau tautan gambar dari Stitch.
- Jika benar-benar butuh gambar (mis. logo), minta PM memasukkannya ke `assets/images/`, lalu pakai `Image.asset('assets/images/nama.png')`. `pubspec.yaml` hanya diubah oleh PM.

## 8. Memakai AI untuk membantu coding

Pakai template ini **apa adanya** untuk semua halaman, lampirkan screenshot desain dari Stitch:

```
Buat halaman Flutter (Material 3) sesuai screenshot terlampir.
Nama class: [NamaPage], file: lib/features/[folder]/[nama]_page.dart
Ketentuan:
- Hanya widget bawaan Flutter, tanpa package eksternal
- Ambil warna dan font dari Theme.of(context), jangan hardcode
- Gunakan widget dari lib/shared/ jika ada (MenuCard, KantinCard, StatusChip,
  AppTextField, AppDrawer, AppBottomNav)
- Data diambil dari lib/core/dummy_data.dart, tanpa database
- Format harga pakai formatRupiah() dari lib/core/utils.dart
- Pindah halaman pakai Navigator.pushNamed(context, AppRoutes.xxx)
  dengan nama route dari lib/core/route_names.dart
- Tombol simpan/hapus cukup memanggil showSnack() lalu Navigator.pop()
- Versi Flutter saya: [hasil `flutter --version`]
- Pastikan tidak overflow di layar kecil (gunakan Expanded/SingleChildScrollView)
```

Tips:
- Minta **satu halaman per kali**, tempel, `flutter run`, perbaiki error, baru lanjut.
- Jika ada error, salin pesan error lengkap ke AI beserta file yang bermasalah.
- Pahami halamanmu sendiri: struktur widget, navigasi, dan cara kerja form. Kalian bisa diminta menjelaskannya.
- Buat desain di Stitch dengan `docs/design.md` (Design System) dan prompt halamanmu dari `docs/stitch_prompts.md`, supaya tampilan seragam.
- Stitch menghasilkan HTML/Tailwind, bukan kode Flutter. Pakai **screenshot** desainnya sebagai masukan untuk AI.

## 9. Git dan branch

```
main                  ← hanya hasil final, di-merge PM
dev                   ← integrasi harian
feat/auth             ← Ahmad
feat/kantin           ← Dandy
feat/menu             ← Raika
feat/pesanan          ← Sukma
```

- Kerja di branch masing-masing. Buka Pull Request ke `dev`, PM yang merge.
- Commit kecil dan sering. Contoh pesan: `feat(menu): tambah halaman edit menu`.
- Sebelum push: `git pull origin dev`, lalu pastikan `flutter run` tanpa error.
- Dilarang push langsung ke `main` dan `dev`.

## 10. Jadwal

| Waktu | Target |
|---|---|
| 14 Okt pagi | Repo dan kerangka selesai, `flutter run` jalan di semua laptop, tema dikonfirmasi |
| 14 Okt siang-sore | Semua anggota mengerjakan halaman masing-masing |
| 14 Okt malam | Merge pertama ke `dev`; jalankan alur penuh sekali |
| 15 Okt siang | Integrasi final, perbaikan, screenshot semua halaman |
| 15 Okt sore | Penyusunan laporan PDF |
| 15 Okt 21.00 | Kumpulkan (batas resmi 23.59 WIB) |

## 11. Definisi "selesai" per halaman

- Tampil tanpa error dan tidak overflow di layar kecil.
- Navigasi masuk dan keluar sesuai route yang dikunci.
- Memakai widget `shared/`, tema, dan data dari `dummy_data.dart`.
- Satu screenshot disimpan di `docs/screenshots/<nama-halaman>.png` untuk laporan.

## 12. Laporan (PDF)

Format sesuai ketentuan dosen: Cover, Deskripsi kelompok dan jobdesk, Kata pengantar, Daftar isi/tabel/gambar, Bab 1 Pendahuluan (latar belakang, batasan, rumusan, tujuan dan manfaat), Bab 2 Landasan teori, Bab 3 Design dan pembahasan, Bab 4 Penutup (kesimpulan, saran), Daftar pustaka.

- **Bab 3**: setiap anggota menulis bagiannya sendiri (halaman CRUD miliknya + screenshot).
- Bab 1, 2, 4, cover, dan kata pengantar dibagi oleh PM.
- Satu orang menyatukan dan merapikan format.
- Tidak perlu diagram activity dan sejenisnya (arahan dosen).
- Di laporan, tulis jelas bahwa login Akun Unsika hanyalah **simulasi tampilan** dan seluruh data adalah dummy.
