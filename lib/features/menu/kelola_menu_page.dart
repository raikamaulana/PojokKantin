import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/theme.dart';
import '../../shared/kantin_bottom_nav.dart';
import '../../shared/app_drawer.dart';
import 'tambah_menu_page.dart';
import 'edit_menu_page.dart';

/// UI pengelolaan menu untuk pemilik kantin (data sementara/in-memory).
class KelolaMenuPage extends StatefulWidget {
  const KelolaMenuPage({super.key, this.kantinId = 'K001'});

  final String kantinId;

  @override
  State<KelolaMenuPage> createState() => _KelolaMenuPageState();
}

class _KelolaMenuPageState extends State<KelolaMenuPage> {
  late final List<MenuKantin> _menus;
  final Map<String, bool> _availability = {};
  final TextEditingController _search = TextEditingController();
  String _category = 'Semua';

  @override
  void initState() {
    super.initState();
    _menus = DummyData.menu.where((m) => m.kantinId == widget.kantinId).toList();
    for (final menu in _menus) {
      _availability[menu.id] = menu.tersedia;
    }
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<MenuKantin> get _filtered => _menus.where((menu) {
        final matchesCategory = _category == 'Semua' || menu.kategori == _category;
        final matchesSearch = menu.nama.toLowerCase().contains(_search.text.trim().toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();

  String _rupiah(int amount) {
    final digits = amount.toString();
    return 'Rp ${digits.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}';
  }

  Future<void> _deleteMenu(MenuKantin menu) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFFFDE8E9),
              child: Icon(Icons.delete_outline, color: AppTheme.accent, size: 28),
            ),
            const SizedBox(height: 16),
            const Text('Hapus Menu?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
          ],
        ),
        content: Text.rich(
          TextSpan(children: [
            const TextSpan(text: 'Yakin ingin menghapus '),
            TextSpan(text: menu.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: ' dari daftar menu kantin?'),
          ]),
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppTheme.textSecondary, height: 1.5),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        actions: [
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Batal'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent, foregroundColor: Colors.white),
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('Ya, Hapus'),
              ),
            ),
          ]),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() {
      _menus.removeWhere((item) => item.id == menu.id);
      _availability.remove(menu.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${menu.nama} dihapus (simulasi).')));
  }

  Future<void> _tambahMenu() async {
    final hasil = await Navigator.push<TambahMenuResult>(
      context,
      MaterialPageRoute(
        builder: (_) => const TambahMenuPage(),
      ),
    );

    if (hasil == null || !mounted) return;

    final menuBaru = MenuKantin(
      id: 'M${DateTime.now().microsecondsSinceEpoch}',
      nama: hasil.nama,
      harga: hasil.harga,
      deskripsi: hasil.deskripsi,
      kategori: hasil.kategori,
      kantinId: widget.kantinId,
      tersedia: hasil.tersedia,
      imagePath: '',
    );

    setState(() {
      _menus.add(menuBaru);
      _availability[menuBaru.id] = hasil.tersedia;
      _category = 'Semua';
      _search.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${hasil.nama} berhasil ditambahkan!'),
      ),
    );
  }

  Future<void> _editMenu(MenuKantin menu) async {
    final hasil = await Navigator.push<EditMenuResult>(
      context,
      MaterialPageRoute(
        builder: (_) => EditMenuPage(
          menu: menu,
          tersediaAwal: _availability[menu.id] ?? menu.tersedia,
        ),
      ),
    );

    if (hasil == null || !mounted) return;

    final menuUpdate = MenuKantin(
      id: menu.id,
      nama: hasil.nama,
      harga: hasil.harga,
      deskripsi: hasil.deskripsi,
      kategori: hasil.kategori,
      kantinId: menu.kantinId,
      tersedia: hasil.tersedia,
      imagePath: menu.imagePath,
    );

    setState(() {
      final index = _menus.indexWhere((m) => m.id == menu.id);

      if (index != -1) {
        _menus[index] = menuUpdate;
        _availability[menu.id] = hasil.tersedia;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${hasil.nama} berhasil diperbarui!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final kantin = DummyData.cariKantin(widget.kantinId);
    final available = _menus.where((m) => _availability[m.id] == true).length;
    final unavailable = _menus.length - available;

    final u = DummyData.currentUser;

    final penjual = AppUser(
      nama: u.nama,
      email: u.email,
      username: u.username,
      nim: u.nim,
      nomorHp: u.nomorHp,
      identitas: u.identitas,
      role: 'penjual',
    );

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 68,
        title: const Text(
          'Kelola Menu',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
        ),
      ),

      drawer: AppDrawer(user: penjual),
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Color(0xFFFFF5F6),
                    Color(0xFFF8DBE1),
                  ],
                  stops: [0.0, 0.48, 1.0],
                ),
              ),
            ),
          ),
          ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _decoration(),
            child: Row(children: [
              _photo(kantin?.imagePath ?? '', width: 64, height: 64, placeholder: Icons.storefront_outlined),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(kantin?.nama ?? 'Kantin', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(kantin?.lokasi ?? '-', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                const SizedBox(height: 4),
                const Text('Kelola menu makanan dan minuman kantinmu.', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
              ])),
            ]),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 125,
            child: Row(children: [
              Expanded(child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(17)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('TOTAL MENU', style: TextStyle(color: Colors.white, fontSize: 12)),
                  const Spacer(),
                  Text('${_menus.length}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32)),
                  const Text('Item aktif terdaftar', style: TextStyle(color: Colors.white70, fontSize: 11)),
                ]),
              )),
              const SizedBox(width: 10),
              Expanded(child: Column(children: [
                Expanded(child: _statTile('TERSEDIA', available, Colors.green.shade700, Icons.check_circle_outline)),
                const SizedBox(height: 8),
                Expanded(child: _statTile('HABIS', unavailable, AppTheme.accent, Icons.cancel_outlined)),
              ])),
            ]),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _search,
            decoration: InputDecoration(
              hintText: 'Cari menu kantin...',
              prefixIcon: const Icon(Icons.search, size: 21),
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: AppTheme.divider)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: AppTheme.divider)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: ['Semua', 'Makanan', 'Minuman', 'Snack'].map((category) {
              final selected = category == _category;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    width: double.infinity,
                    child: ChoiceChip(
                      label: SizedBox(
                        width: double.infinity,
                        child: Text(
                          category,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      selected: selected,
                      showCheckmark: false,
                      selectedColor: AppTheme.primary,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : AppTheme.textSecondary,
                        fontSize: 12,
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: selected ? AppTheme.primary : AppTheme.divider,
                      ),
                      onSelected: (_) => setState(() => _category = category),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(children: [
            const Expanded(child: Text('Daftar Menu Kantin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
            Text('(${_filtered.length})', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _tambahMenu,
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), minimumSize: const Size(0, 36), visualDensity: VisualDensity.compact),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Tambah Menu', style: TextStyle(fontSize: 12)),
            ),
          ]),
          const SizedBox(height: 12),
          if (_filtered.isEmpty)
            const Padding(padding: EdgeInsets.all(36), child: Center(child: Text('Menu tidak ditemukan.')))
          else
            ..._filtered.map((menu) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _menuCard(menu),
            )),
        ],
          ),
        ],
      ),
      bottomNavigationBar: const KantinBottomNav(currentIndex: 1),
    );
  }

  BoxDecoration _decoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(17),
    border: Border.all(color: AppTheme.divider),
  );

  Widget _photo(String path, {required double width, required double height, required IconData placeholder}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(width: width, height: height, child: path.isEmpty
        ? Container(color: AppTheme.tint, child: Icon(placeholder, color: AppTheme.accent))
        : Image.asset(path, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: AppTheme.tint, child: Icon(placeholder, color: AppTheme.accent)))),
    );
  }

  Widget _statTile(String label, int value, Color color, IconData icon) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: _decoration(),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
        Text('$value Menu', style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
      ])),
      Icon(icon, color: color, size: 21),
    ]),
  );

  Widget _menuCard(MenuKantin menu) {
    final isAvailable = _availability[menu.id] ?? false;
    final badgeColor = switch (menu.kategori) {
      'Makanan' => const Color(0xFFFBE6E7),
      'Minuman' => const Color(0xFFE8F1FF),
      _ => const Color(0xFFFFEFD8),
    };
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _decoration(),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _photo(menu.imagePath, width: 72, height: 72, placeholder: Icons.restaurant_menu),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(menu.nama, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
              const SizedBox(width: 5),
              Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4), decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(12)), child: Text(menu.kategori, style: const TextStyle(fontSize: 10))),
            ]),
            const SizedBox(height: 4),
            Text(menu.deskripsi, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
            const SizedBox(height: 6),
            Text(_rupiah(menu.harga), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isAvailable ? AppTheme.accent : AppTheme.textSecondary, decoration: isAvailable ? null : TextDecoration.lineThrough)),
          ])),
        ]),
        const SizedBox(height: 12),
        const Divider(height: 1, color: AppTheme.divider),
        const SizedBox(height: 8),
        Row(children: [
          Transform.scale(scale: .82, alignment: Alignment.centerLeft, child: Switch(
            value: isAvailable,
            activeTrackColor: const Color(0xFF138344),
            inactiveTrackColor: const Color(0xFFE3A2A2),
            thumbColor: WidgetStateProperty.all(Colors.white),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            onChanged: (value) {
              setState(() => _availability[menu.id] = value);
            },
          )),
          Text(isAvailable ? 'Tersedia' : 'Habis', style: TextStyle(fontSize: 12, color: isAvailable ? const Color(0xFF138344) : AppTheme.accent)),
          const Spacer(),
          _actionIcon(Icons.edit_outlined, 'Edit ${menu.nama}', () => _editMenu(menu)),
          const SizedBox(width: 8),
          _actionIcon(Icons.delete_outline, 'Hapus ${menu.nama}', () => _deleteMenu(menu)),
        ]),
      ]),
    );
  }

  Widget _actionIcon(IconData icon, String tooltip, VoidCallback action) => InkWell(
    onTap: action,
    borderRadius: BorderRadius.circular(9),
    child: Tooltip(message: tooltip, child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: AppTheme.background, border: Border.all(color: AppTheme.divider), borderRadius: BorderRadius.circular(9)),
      child: Icon(icon, size: 18, color: AppTheme.textSecondary),
    )),
  );
}
