
import 'package:flutter/material.dart';

import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../shared/app_bottom_nav.dart';
import '../../shared/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Makanan',
    'Minuman',
    'Snack',
    'Kantin',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase().trim();

    final filteredMenu = DummyData.menu.where((menu) {
      final matchesCategory =
          _selectedCategory == 'Semua' ||
          _selectedCategory == 'Kantin' ||
          menu.kategori.toLowerCase() ==
              _selectedCategory.toLowerCase();

      final kantin = DummyData.cariKantin(menu.kantinId);

      final matchesSearch =
          menu.nama.toLowerCase().contains(query) ||
          menu.deskripsi.toLowerCase().contains(query) ||
          (kantin?.nama.toLowerCase().contains(query) ?? false);

      return matchesCategory && matchesSearch;
    }).toList();

    final filteredKantin = DummyData.kantin.where((kantin) {
      return kantin.nama.toLowerCase().contains(query) ||
          kantin.lokasi.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 68,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pojok Kantin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3),
            Text(
              '— UNSIKA —',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Background gradasi fixed mengikuti ukuran layar
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFF5F6),
                      Color(0xFFF8DBE1),
                    ],
                  ),
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${DummyData.currentUser.nama} 👋',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Mau pesan makan apa hari ini di kantin belakang?',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Pencarian
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Cari makanan, minuman, atau kantin...',
                      hintStyle: const TextStyle(fontSize: 12),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Filter kategori
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final selected = category == _selectedCategory;

                        return ChoiceChip(
                          label: Text(category),
                          selected: selected,
                          showCheckmark: false,
                          onSelected: (_) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          selectedColor: AppTheme.tint,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: selected
                                ? AppTheme.primary
                                : AppTheme.textSecondary,
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          side: BorderSide(
                            color: selected
                                ? AppTheme.accent
                                : AppTheme.divider,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 26),

                  // Daftar kantin
                  if (_selectedCategory == 'Semua' ||
                      _selectedCategory == 'Kantin') ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Kantin Kampus',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.kantinMenuList,
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Lihat Semua',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (filteredKantin.isEmpty)
                      const Text('Kantin tidak ditemukan.')
                    else
                      SizedBox(
                        height: 210,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredKantin.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final kantin = filteredKantin[index];

                            return _HomeKantinCard(
                              kantin: kantin,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.kantinMenuList,
                                  arguments: kantin.id,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 26),
                  ],

                  // Daftar menu populer
                  if (_selectedCategory != 'Kantin') ...[
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Menu Populer Mahasiswa',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Paling sering dipesan',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (filteredMenu.isEmpty)
                      const Text('Menu tidak ditemukan.')
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredMenu.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final menu = filteredMenu[index];

                          return _HomeMenuCard(
                            menu: menu,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.menuDetail,
                                arguments: menu,
                              );
                            },
                            onAdd: () {
                              showSnack(
                                context,
                                '${menu.nama} dipilih. Fitur keranjang akan dihubungkan nanti.',
                              );
                            },
                          );
                        },
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      )
      
      
    );
  }
}

// Kartu kantin khusus tampilan Beranda

class _HomeKantinCard extends StatelessWidget {
  final Kantin kantin;
  final VoidCallback onTap;

  const _HomeKantinCard({
    required this.kantin,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Status operasional dummy untuk kebutuhan demo.
    // Tidak mengikuti jam perangkat.
    final bool isOpen = kantin.id != 'K003';

    return SizedBox(
      width: 225,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 105,
                width: double.infinity,
                child: kantin.imagePath.isNotEmpty
                    ? Image.asset(
                        kantin.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Center(
                          child: Icon(Icons.storefront_outlined),
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.storefront_outlined),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            kantin.nama,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isOpen
                                ? const Color(0xFFE2F4E7)
                                : const Color(0xFFFCE5E5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isOpen ? 'Buka' : 'Tutup',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isOpen
                                  ? const Color(0xFF258345)
                                  : AppTheme.accent,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            kantin.lokasi,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          size: 14,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Buka ${kantin.jamBuka} - ${kantin.jamTutup}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Kartu menu khusus tampilan Beranda
class _HomeMenuCard extends StatelessWidget {
  final MenuKantin menu;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  const _HomeMenuCard({
    required this.menu,
    required this.onTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final kantin = DummyData.cariKantin(menu.kantinId);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 94,
                  height: 105,
                  child: menu.imagePath.isNotEmpty
                      ? Image.asset(
                          menu.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              const Icon(Icons.restaurant_outlined),
                        )
                      : const Icon(Icons.restaurant_outlined),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      kantin?.nama ?? 'Kantin Kampus',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      menu.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            formatRupiah(menu.harga),
                            style: const TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (menu.tersedia)
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: IconButton.filled(
                              onPressed: onAdd,
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.add, size: 18),
                            ),
                          )
                        else
                          const Text(
                            'Habis',
                            style: TextStyle(
                              color: AppTheme.accent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
