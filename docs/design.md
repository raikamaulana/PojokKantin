# PojokKantin — Design System

Import file ini ke Google Stitch sebagai Design System proyek. Halaman-halamannya dibuat dengan prompt di `docs/stitch_prompts.md`.

## Identitas aplikasi
- Nama aplikasi: **Pojok Kantin**.
- Identitas kampus: **-- UNSIKA --** tepat di bawah nama aplikasi, rata tengah.
- Pada Splash, Login, Register, dan Onboarding, gunakan susunan dua baris berikut (jangan dibalik):

  **Pojok Kantin**  
  **-- UNSIKA --**

- Baris pertama lebih besar dan tebal; baris kedua lebih kecil. Gunakan teks yang sama persis, bukan "UNSIKA Pojok Kantin".
- Untuk saat ini gunakan ikon `restaurant` sebagai simbol sementara; logo resmi UNSIKA belum diberikan dan jangan mengarangnya.

## Overview
PojokKantin adalah aplikasi mobile (Android, portrait, 360x800) untuk mahasiswa UNSIKA memesan makanan kantin lebih dulu dan mengambilnya sesuai jam. Mahasiswa juga bisa mendaftar sebagai penjual dan diperiksa admin.

Karakter: bersih, ramah, kampus. Banyak ruang kosong, sudut membulat, bayangan tipis. Semua teks antarmuka berbahasa Indonesia. Gaya Material 3.

## Colors
Dua warna utama, dipakai dengan peran berbeda:

| Peran | Nama | Hex | Dipakai untuk |
|---|---|---|---|
| Primary | Merah marun | `#800000` | AppBar, header drawer, tombol utama, judul penting, ikon aktif |
| Accent | Merah terang | `#D6333F` | Harga, tombol aksi (Tambah ke Keranjang, Checkout, Buat Pesanan), badge, FAB |
| On primary / on accent | Putih | `#FFFFFF` | Teks dan ikon di atas dua warna di atas |
| Tint | Marun muda | `#F6E3E5` | Latar kotak ikon/gambar, chip terpilih, baris yang disorot |
| Background | Putih gading | `#FAF7F7` | Latar halaman |
| Surface | Putih | `#FFFFFF` | Kartu, form, dialog |
| Text | Hampir hitam | `#1F1A1A` | Teks utama |
| Text secondary | Abu hangat | `#6B5F5F` | Deskripsi, label, teks bantu |
| Divider | Abu muda | `#E6DEDE` | Garis pemisah, border input |

Status pesanan dan pengajuan (warna muda, teks gelap):
- Diproses / Menunggu: oranye muda
- Siap diambil: biru muda
- Selesai / Disetujui: hijau muda
- Dibatalkan / Ditolak: merah muda (bukan merah brand penuh)

Aturan: jangan memakai warna di luar tabel ini selain untuk status. Satu halaman maksimal satu tombol aksi berwarna Accent.

## Typography
Font Roboto (bawaan Material).
- Judul halaman: 20, tebal
- Judul kartu: 16, medium
- Isi: 14, reguler
- Label/chip: 12, medium
- Harga: 16, tebal, warna Accent

## Shape & Spacing
- Sudut kartu dan tombol: 12; chip dan badge: 20 (pil)
- Padding halaman: 16; jarak antar kartu: 8-12
- Jarak kelompok drawer: 12–16; label kategori ke menu: 6–8
- Kartu: putih, bayangan sangat tipis, tanpa border tebal
- Tombol utama lebar penuh, tinggi 48

## Components
- **AppBar Beranda:** Primary, ikon hamburger di kiri, branding "Pojok Kantin" / "-- UNSIKA --" dua baris di tengah; tidak ada ikon keranjang/profil di kanan. Konten Beranda langsung dimulai dengan sapaan, tanpa heading "Beranda" terpisah.
- **AppBar halaman lain:** judul putih sesuai nama halaman, dengan tombol kembali atau navigasi yang relevan.
- **Bottom Navigation pembeli:** Beranda, Pesanan, Keranjang, Profil; ikon Material outlined, item aktif Primary. Tidak perlu mengulang keempat menu ini dalam kelompok navigasi drawer (kecuali "Profil Saya" yang memang disepakati tampil di drawer).
- **Drawer:** header Primary berisi avatar, nama, email, serta badge status kecil terpisah tepat di bawah email (misalnya `Mahasiswa` dan `Penjual`; tanpa label fakultas/prodi). Badge berbentuk pill, latar putih transparan 15–20%, teks putih, jarak antarbadge sekitar 6px dan jarak dari email sekitar 8px; tinggi header disesuaikan seperlunya. "Profil Saya" langsung di bawah header. Kelompok berlabel LAYANAN KANTIN → "Daftar Jadi Penjual"; PANEL PENJUAL → "Dashboard Kantin"; ADMIN → "Cek Pengajuan Kantin"; AKUN → "Keluar Akun" berwarna merah. Menu pengajuan menuju daftar pengajuan admin untuk menyetujui/menolak pendaftaran kantin, bukan panel admin umum.
- **Drawer spacing:** jarak antarkelompok 12–16px; label ke item 6–8px; jarak sebelum AKUN dapat sedikit lebih besar (~20px). Gunakan whitespace dan label tanpa garis pemisah horizontal antarkelompok.
- **Role dummy:** desain Stitch drawer lengkap menampilkan semua kategori sebagai referensi. Dalam Flutter, tampilkan hanya menu sesuai role simulasi (`mahasiswa`, `penjual`, `admin`), tanpa backend atau autentikasi nyata. Status identitas terpisah dari akses: `Mahasiswa`, `Staf UNSIKA`, atau `Pengguna Umum`; akses `Penjual` dapat digabung dengan status identitas setelah pengajuan disetujui, sedangkan `Admin` tampil sendiri dan tidak merangkap Penjual. Tidak ada diskon atau privilege khusus berdasarkan status identitas. Semua menggunakan dummy data.
- **Kartu menu:** kotak 64x64 warna Tint di kiri (ikon di tengah, bukan foto), nama, deskripsi 2 baris, harga Accent di bawah
- **Kartu kantin:** kotak 64x64 Tint dengan ikon toko, nama, lokasi, "Buka 07.00 - 16.00"
- **Format lokasi kantin:** tampilkan `Zona Kiri, No. 1` atau `Zona Kanan, No. 2`. Zona mengacu pada dua deretan warung dari arah jalan masuk kantin belakang UNSIKA; nomor dimulai dari awal masing-masing deretan. Ini sistem penomoran usulan untuk data dummy, bukan nomor resmi di lokasi. Form pendaftaran/edit kantin memakai pilihan zona (Kiri/Kanan) dan nomor kantin; gunakan format sama pada detail kantin dan informasi pengambilan pesanan.
- **Tombol utama:** isi Primary atau Accent, teks putih; **tombol sekunder:** outline Primary
- **Input:** label mengambang, border Divider, border Primary saat fokus
- **Chip status:** pil kecil berwarna sesuai status
- **Dialog:** sudut 16, tombol Batal (teks) dan aksi (isi)

## Icons
- **Hanya ikon Material** (Material Icons / Material Symbols), gaya outlined.
- Tidak boleh memakai ikon dari set lain (Font Awesome, Lucide, dll.) dan tidak memakai emoji sebagai ikon.
- Ikon yang dipakai (semua ada di Flutter): `home`, `person`, `chevron_right`, `close`, `shopping_cart`, `receipt_long`, `storefront`, `dashboard`, `fact_check`, `assignment_turned_in`, `restaurant`, `search`, `add`, `edit`, `delete`, `logout`, `schedule`, `payments`, `check_circle`, `cancel`, `school`, `menu`, `arrow_back`, `lock`, `phone`, `mail`, `location_on`, `photo_camera`.

## Images
- Tidak ada foto. Tempat gambar diisi kotak berwarna Tint dengan ikon Material di tengah.
- Belum ada logo resmi yang disertakan; untuk sementara gunakan ikon `restaurant` di lingkaran Primary. Jika aset logo resmi UNSIKA diberikan nanti, penggunaannya perlu dikonfirmasi terlebih dahulu.

## Data contoh (pakai ini, jangan karang sendiri)
- User: Rina Maharani, 2410631170100@student.unsika.ac.id, NIM 2410631170100, 081234567890
- Kantin: Kantin Bu Siti, Zona Kiri, No. 1, buka 07.00 - 16.00
- Kantin lain: Kedai Kopi Kampus (Zona Kanan, No. 2), Warung Teknik (Zona Kiri, No. 3)
- Menu: Nasi Ayam Geprek Rp 15.000, Nasi Rames Rp 12.000, Es Teh Manis Rp 4.000, Pisang Goreng Rp 6.000 (habis)
- Pesanan: ORD-001 Diproses (Nasi Ayam Geprek + Es Teh Manis, ambil 12.15), ORD-002 Siap diambil
- Pengajuan kantin: Kantin Sehat Ibu Dewi, Bakso Pak Joko

## Beranda pembeli (acuan Stitch final)
- Sapaan "Halo, Rina Maharani" dan teks pendamping tampil langsung di bawah AppBar.
- Satu banner ringkas "Pesan Dulu, Ambil Nanti!" dengan penjelasan singkat manfaat pre-order.
- Pencarian, filter kategori, daftar kantin, dan bagian "Menu Favorit Mahasiswa" dengan subtitle "Pilihan favorit di kantin kampus".
- Bottom Navigation empat menu tetap terlihat pada halaman utama pembeli.

## Do / Don't
- Do: konsisten memakai dua warna utama dengan peran di atas, kontras teks cukup, tombol minimal 48 tinggi.
- Don't: gradasi mencolok, foto makanan, bayangan tebal, lebih dari dua warna utama, teks bahasa Inggris.
