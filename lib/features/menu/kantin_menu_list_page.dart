import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../shared/app_bottom_nav.dart';
import '../../core/dummy_data.dart';
import '../../core/models.dart';
import '../../core/route_names.dart';


class KantinMenuListPage extends StatefulWidget {
  final String? kantinId;

  const KantinMenuListPage({
    super.key,
    this.kantinId,
  });

  @override
  State<KantinMenuListPage> createState() => _KantinMenuListPageState();
}

class _KantinMenuListPageState extends State<KantinMenuListPage> {
  late final PageController _pageController;
  int _selectedKantinIndex = 0;

  @override
  void initState() {
    super.initState();

    final index = DummyData.kantin.indexWhere(
      (kantin) => kantin.id == widget.kantinId,
    );

    _selectedKantinIndex = index >= 0 ? index : 0;

    _pageController = PageController(
      initialPage: _selectedKantinIndex,
      viewportFraction: 0.92,
    );
  }
  String _searchQuery = '';

  List<MenuKantin> get _filteredMenu {
    final kantinId = DummyData.kantin[_selectedKantinIndex].id;

    return DummyData.menu.where((menu) {
      final sesuaiKantin = menu.kantinId == kantinId;

      final sesuaiPencarian =
          menu.nama.toLowerCase().contains(_searchQuery);

      final sesuaiKategori =
          _selectedCategory == 'Semua' ||
          menu.kategori.toLowerCase() == _selectedCategory.toLowerCase();

      return sesuaiKantin && sesuaiPencarian && sesuaiKategori;
    }).toList();
  }

  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Makanan',
    'Minuman',
    'Snack',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.divider,
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value.trim().toLowerCase();
          });
        },
        style: const TextStyle(
          fontSize: 13,
          color: AppTheme.textPrimary,
        ),
        decoration: const InputDecoration(
          hintText: 'Cari menu di kantin ini...',
          hintStyle: TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondary,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppTheme.textSecondary,
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: ChoiceChip(
                label: SizedBox(
                  width: double.infinity,
                  child: Text(
                    category,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                selected: isSelected,
                showCheckmark: false,
                onSelected: (_) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
                backgroundColor: Colors.white,
                selectedColor: AppTheme.primary,
                side: BorderSide(
                  color: isSelected
                      ? AppTheme.primary
                      : AppTheme.divider,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 8,
                ),
                labelPadding: EdgeInsets.zero,
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : AppTheme.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuList() {
    final menuList = _filteredMenu;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Menu Tersedia',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                '${menuList.length} Menu',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (menuList.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  'Kantin belum ada menu di kategori ini',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            )
          else
            ...menuList.map((menu) => _buildMenuCard(menu)),
        ],
      ),
    );
  }

  String _formatHarga(num harga) {
    final angka = harga.toStringAsFixed(0);

    return 'Rp${angka.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }

  Widget _buildMenuCard(MenuKantin menu) {
    final isOpen = DummyData.kantin[_selectedKantinIndex].id != 'K003';
    final canOrder = isOpen && menu.tersedia;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.menuDetail,
          arguments: menu,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.divider),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 88,
                height: 88,
                child: Opacity(
                  opacity: menu.tersedia ? 1.0 : 0.45,
                  child: Image.asset(
                    menu.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.restaurant_menu_rounded,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
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
                          _formatHarga(menu.harga),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),

                      if (canOrder)
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.menuDetail,
                                arguments: menu,
                              );
                            },
                            padding: EdgeInsets.zero,
                            style: IconButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.add_rounded,
                              size: 20,
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.tint,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            !isOpen ? 'Tutup' : 'Habis',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primary,
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
    );
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daftar Menu Kantin',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

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
                        Color(0xFFF5D0D7),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    SizedBox(
                      height: 116,
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const PageScrollPhysics(),
                        itemCount: DummyData.kantin.length,
                        onPageChanged: (index) {
                          setState(() {
                            _selectedKantinIndex = index;
                            _selectedCategory = 'Semua';
                          });
                        },
                        itemBuilder: (context, index) {
                          final kantin = DummyData.kantin[index];

                          // Status dummy.
                          final bool isOpen = kantin.id != 'K003';

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              color: Colors.white,
                              elevation: 1,
                              shadowColor: AppTheme.primary.withValues(alpha: 0.08),
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: const BorderSide(
                                  color: AppTheme.divider,
                                  width: 0.8,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: SizedBox(
                                        width: 85,
                                        height: 85,
                                        child: kantin.imagePath.isNotEmpty
                                            ? Image.asset(
                                                kantin.imagePath,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, _, _) =>
                                                    const Icon(Icons.storefront_outlined),
                                              )
                                            : const Icon(Icons.storefront_outlined),
                                      ),
                                    ),

                                    const SizedBox(width: 16),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  kantin.nama,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppTheme.textPrimary,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(width: 6),

                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
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

                                          const SizedBox(height: 8),

                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                size: 15,
                                                color: AppTheme.primary,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  kantin.lokasi,
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

                                          const SizedBox(height: 4),

                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time_outlined,
                                                size: 15,
                                                color: AppTheme.primary,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${kantin.jamBuka}–${kantin.jamTutup}',
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: AppTheme.textSecondary,
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
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        DummyData.kantin.length,
                        (index) => InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 8,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: _selectedKantinIndex == index ? 18 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _selectedKantinIndex == index
                                    ? AppTheme.primary
                                    : AppTheme.divider,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildSearchBar(),
                    ),

                    const SizedBox(height: 16),

                    _buildCategoryFilter(),

                    const SizedBox(height: 24),

                    _buildMenuList(),

                    const SizedBox(height: 24),
                  ],
                ),
              )
          ],
        ),
      ),

      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}