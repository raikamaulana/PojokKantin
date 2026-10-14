# Prompt Stitch per Halaman

`design.md` hanya mengatur **gaya** (warna, font, komponen). Isi tiap halaman tetap harus dijelaskan lewat prompt. Satu prompt = satu halaman. Tempel awalan umum, lalu prompt halaman.

## Cara pakai
1. Buat proyek Stitch bertipe **App** (mobile).
2. Lampirkan `docs/design.md` sebagai referensi gaya pada prompt Stitch. Jangan menganggap lampiran otomatis mengubah Design System global kecuali fitur impor proyek memang tersedia.
3. Tempel **awalan umum** + prompt halamanmu, lalu generate.
4. Periksa: warna hanya marun dan merah terang, ikon hanya Material, teks bahasa Indonesia, data sesuai contoh.
5. Jika desain berubah setelah Design System diedit, pilih semua halaman lalu terapkan ulang Design System (Modify > Design System).
6. Screenshot hasilnya untuk dipakai saat meminta AI menulis kode Flutter, dan simpan di `docs/screenshots/`.

## Awalan umum (tempel di setiap prompt)
```
Layar aplikasi mobile 360x800, ikuti referensi gaya Pojok Kantin dari design.md dan desain Login, Beranda, serta Drawer yang sudah disetujui.
Identitas branding wajib: "Pojok Kantin" di baris atas, "-- UNSIKA --" tepat di bawahnya, rata tengah; baris atas lebih besar dan tebal.
Tampilkan identitas dua baris ini pada Splash, Login, Register, dan Onboarding; jangan dibalik.
Semua teks bahasa Indonesia. Hanya ikon Material outlined. Tidak ada foto;
gambar diganti kotak berwarna marun muda dengan ikon. Pakai data contoh dari design.md. Lokasi kantin selalu memakai format "Zona Kiri, No. 1" atau "Zona Kanan, No. 2"; ini nomor dummy usulan aplikasi, bukan nomor resmi di lapangan.
Satu tombol aksi berwarna merah terang per halaman, tombol utama lain marun.
Halaman utama pembeli memakai Bottom Navigation: Beranda, Pesanan, Keranjang, Profil.
AppBar Beranda: hamburger kiri dan branding dua baris di tengah, tanpa ikon keranjang/profil di kanan.
Halaman lain memakai judul AppBar sesuai fungsi. Drawer memakai header profil dan kategori menu sesuai design.md.
Gunakan menu berdasarkan role dummy dalam implementasi; desain Drawer lengkap hanyalah referensi.
```

## Ahmad — auth
1. **Splash:** latar marun penuh, ikon `restaurant` di lingkaran putih, identitas dua baris "Pojok Kantin" lalu "-- UNSIKA --" tepat di bawahnya, tagline "Pesan dulu, ambil kemudian".
2. **Onboarding:** identitas dua baris di area branding, 3 slide dengan indikator titik. (1) Pilih kantin favoritmu, (2) Pesan dan tentukan jam ambil, (3) Ambil tanpa antre. Tiap slide: ikon besar di lingkaran marun muda, judul, deskripsi singkat. Tombol "Lewati" di kanan atas dan "Lanjut" di bawah.
3. **Login:** ikon `restaurant` kecil dan identitas dua baris "Pojok Kantin" / "-- UNSIKA --" di atas form, judul "Masuk", kolom username/email, kolom password, tombol marun "Masuk", tombol outline "Masuk dengan Akun Unsika" (ikon `school`), teks "Belum punya akun? Daftar".
4. **Register:** identitas dua baris "Pojok Kantin" / "-- UNSIKA --" di atas form, judul "Buat Akun", tombol besar "Daftar dengan Akun Unsika", teks bantu "Data dasar akan terisi dari akun kampusmu", teks "Sudah punya akun? Masuk".
5. **Form Data Diri:** judul "Lengkapi Data Dirimu". Kolom nama dan email terisi dan tidak bisa diubah (label "Dari akun Unsika"), kolom tambahan: username, NIM, nomor HP. Tombol "Simpan & Lanjut".
6. **Profil:** avatar lingkaran dengan inisial, nama, email, daftar info (username, NIM, nomor HP) dengan ikon, tombol "Edit Profil".
7. **Edit Profil:** form berisi data profil terisi, tombol "Simpan Perubahan", tautan teks merah "Hapus Akun" di bawah.

## Dandy — kantin dan admin
8. **Daftar Jadi Penjual:** judul "Daftarkan Kantinmu", kolom nama kantin, deskripsi (multi baris), lokasi berupa pilihan Zona Kiri/Kanan dan nomor kantin (contoh Zona Kiri, No. 1), jam buka, kotak unggah foto (ikon `photo_camera`), tombol "Kirim Pengajuan".
9. **Menunggu Persetujuan:** ikon `schedule` besar, judul "Pengajuan Sedang Ditinjau", teks "Admin akan memeriksa pengajuanmu", kartu ringkasan data kantin dengan chip "Menunggu", tombol "Kembali ke Beranda".
10. **Dashboard Kantin:** header "Kantin Bu Siti", 3 kartu ringkasan (Menu 4, Pesanan Hari Ini 3, Pesanan Diproses 1), grid 3 pintasan: Menu Saya, Pesanan Masuk, Profil Kantin.
11. **Profil Kantin:** kotak ikon toko besar, nama, deskripsi, lokasi dengan format Zona Kiri/Kanan, No. [nomor], jam buka, tombol "Edit Kantin".
12. **Edit Kantin:** form terisi data kantin termasuk pilihan zona dan nomor kantin, tombol "Simpan Perubahan", tautan teks merah "Hapus Kantin".
13. **Cek Pengajuan Kantin (admin):** daftar kartu pengajuan (Kantin Sehat Ibu Dewi, Bakso Pak Joko), tiap kartu punya chip "Menunggu" dan panah ke detail.
14. **Detail Pengajuan (admin):** data lengkap kantin dan pemohon, dua tombol di bawah: "Setujui" (isi marun) dan "Tolak" (outline merah).

## Raika — menu
15. **Beranda:** AppBar marun dengan hamburger kiri, branding "Pojok Kantin" / "-- UNSIKA --" di tengah, tanpa ikon keranjang/profil kanan dan tanpa heading "Beranda" di bawahnya. Sapaan "Halo, Rina Maharani", subtitle "Mau pesan makan apa hari ini di kampus?", banner kecil "Pesan Dulu, Ambil Nanti!", kolom pencarian, chip kategori (Semua, Makanan, Minuman, Snack, Kantin), kartu kantin, bagian "Menu Favorit Mahasiswa" dengan subtitle "Pilihan favorit di kantin kampus", daftar menu dummy, dan Bottom Navigation Beranda/Pesanan/Keranjang/Profil.
16. **Daftar Menu Kantin:** header nama dan lokasi kantin (contoh Zona Kiri, No. 1), daftar kartu menu (4 menu, satu berstatus "Habis"), tombol keranjang melayang berwarna merah terang.
17. **Detail Menu:** kotak gambar besar marun muda dengan ikon, nama, harga, deskripsi, pengatur jumlah (- 1 +), tombol merah terang "Tambah ke Keranjang".
18. **Menu Saya (penjual):** daftar kartu menu, tiap kartu punya ikon edit dan hapus di kanan, tombol melayang "Tambah Menu".
19. **Tambah Menu:** form nama, kategori (dropdown), harga, deskripsi, saklar "Tersedia", kotak unggah foto, tombol "Simpan Menu".
20. **Edit Menu:** sama seperti Tambah Menu tetapi terisi data, tombol "Simpan Perubahan" dan tautan teks merah "Hapus Menu".

## Sukma — pesanan
21. **Keranjang:** daftar item dengan pengatur jumlah dan ikon hapus, baris ringkasan total, tombol merah terang "Checkout".
22. **Checkout:** ringkasan pesanan beserta lokasi kantin (format Zona Kiri/Kanan, No. [nomor]), pilihan jam ambil (daftar waktu), pilihan metode pembayaran (Tunai di kantin, QRIS, E-wallet) berupa radio, total, tombol merah terang "Buat Pesanan".
23. **Riwayat Pesanan:** tab "Aktif" dan "Selesai", daftar kartu pesanan (ORD-001 Diproses, ORD-002 Siap diambil) dengan chip status dan total.
24. **Detail Pesanan:** indikator langkah Diproses > Siap diambil > Selesai, daftar item, lokasi pengambilan kantin (format Zona Kiri/Kanan, No. [nomor]), jam ambil, total, tombol outline merah "Batalkan Pesanan".
25. **Pesanan Masuk (penjual):** chip filter (Semua, Diproses, Siap, Selesai), daftar kartu pesanan berisi nama pembeli, ringkasan item, jam ambil, chip status.
26. **Detail Pesanan Masuk (penjual):** data pembeli, daftar item, jam ambil, total, tombol "Tandai Siap Diambil" dan tombol sekunder "Tandai Selesai".

## Referensi komponen tambahan — Drawer (bukan halaman ke-27)
Buat satu mockup Beranda dengan drawer kiri terbuka sebagai acuan `shared/app_drawer.dart`. Header marun: avatar, "Rina Maharani", "2410631170100@student.unsika.ac.id", lalu dua badge pill kecil terpisah `Mahasiswa` dan `Penjual` di bawah email (latar putih transparan 15–20%, teks putih, jarak antarbadge 6px, jarak dari email 8px); tinggi header boleh bertambah secukupnya. Status contoh lain: `Staf UNSIKA`, `Staf UNSIKA` + `Penjual`, `Pengguna Umum`, `Penjual`, atau `Admin` saja. Admin tidak merangkap Penjual; status identitas tidak memberi privilege khusus. Menu "Profil Saya" di bawah header. Kelompok LAYANAN KANTIN → "Daftar Jadi Penjual"; PANEL PENJUAL → "Dashboard Kantin"; ADMIN → "Cek Pengajuan Kantin" (untuk meninjau, menyetujui, atau menolak pengajuan); AKUN → "Keluar Akun" merah. Gunakan label kategori dan jarak antarkelompok 12–16px, label ke menu 6–8px, tanpa divider horizontal. Mockup lengkap boleh menampilkan semua menu; implementasi Flutter menyesuaikan role dummy.
