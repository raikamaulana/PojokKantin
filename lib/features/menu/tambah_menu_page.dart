import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme.dart';

/// Data form yang dikirim kembali ke KelolaMenuPage tanpa database.
class TambahMenuResult {
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final bool tersedia;

  const TambahMenuResult({
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.tersedia,
  });
}

class TambahMenuPage extends StatefulWidget {
  const TambahMenuPage({super.key});

  @override
  State<TambahMenuPage> createState() => _TambahMenuPageState();
}

class _TambahMenuPageState extends State<TambahMenuPage> {
  final _formKey = GlobalKey<FormState>();
  final _nama = TextEditingController();
  final _harga = TextEditingController();
  final _deskripsi = TextEditingController();
  String _kategori = 'Makanan';
  bool _tersedia = true;

  @override
  void dispose() {
    _nama.dispose();
    _harga.dispose();
    _deskripsi.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    final harga = int.parse(_harga.text.replaceAll('.', ''));
    Navigator.of(context).pop(TambahMenuResult(
      nama: _nama.text.trim(),
      kategori: _kategori,
      harga: harga,
      deskripsi: _deskripsi.text.trim(),
      tersedia: _tersedia,
    ));
  }

  InputDecoration _inputDecoration(String hint, {Widget? prefix}) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9E9292)),
        filled: true,
        fillColor: const Color(0xFFFBF0F0),
        prefixIcon: prefix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 19),
      );

  Widget _panel(Widget child) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [BoxShadow(color: Color(0x09000000), blurRadius: 12, offset: Offset(0, 3))],
        ),
        child: child,
      );

  Widget _label(String label, {bool required = false}) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text.rich(TextSpan(children: [
          TextSpan(text: label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppTheme.textPrimary)),
          if (required) const TextSpan(text: ' *', style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.bold)),
        ])),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        toolbarHeight: 78,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(22))),
        centerTitle: false,
        titleSpacing: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tambah Menu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 3),
            Text('Lengkapi informasi menu kantinmu', style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
          ],
        ),
      ),

      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFFFF), Color(0xFFFAF7F7), Color(0xFFF8E1E6)],
            ))),
          ),
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 26),
              children: [
                _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Icon(Icons.photo_camera_outlined, color: AppTheme.primary),
                    const SizedBox(width: 8),
                    const Expanded(child: Text('Foto Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                    _chip('Opsional', const Color(0xFFF7EBEB), AppTheme.textSecondary),
                  ]),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                    decoration: BoxDecoration(color: const Color(0xFFFBF0F0), borderRadius: BorderRadius.circular(18)),
                    child: const Column(children: [
                      CircleAvatar(radius: 26, backgroundColor: Color(0xFFF7E4E6), child: Icon(Icons.add_a_photo_outlined, size: 24, color: AppTheme.primary)),
                      SizedBox(height: 12),
                      Text('Tambahkan Foto Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(height: 8),
                      Text('Fitur pilih foto akan dihubungkan nanti', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                      SizedBox(height: 12),
                      Text('JPG atau PNG', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    ]),
                  ),
                ])),
                const SizedBox(height: 18),
                _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _label('Nama Menu', required: true),
                  TextFormField(
                    controller: _nama,
                    maxLength: 80,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: _inputDecoration('Contoh: Nasi Ayam Geprek').copyWith(counterText: ''),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Nama menu wajib diisi' : null,
                  ),
                  const SizedBox(height: 20),
                  _label('Kategori Menu', required: true),
                  Row(children: ['Makanan', 'Minuman', 'Snack'].map((kategori) {
                    final selected = _kategori == kategori;
                    return Expanded(child: Padding(
                      padding: EdgeInsets.only(right: kategori == 'Snack' ? 0 : 8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => setState(() => _kategori = kategori),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                          decoration: BoxDecoration(color: selected ? AppTheme.primary : const Color(0xFFFBF0F0), borderRadius: BorderRadius.circular(14)),
                          child: FittedBox(fit: BoxFit.scaleDown, child: Row(mainAxisSize: MainAxisSize.min, children: [
                            if (selected) const Padding(padding: EdgeInsets.only(right: 4), child: Icon(Icons.check, color: Colors.white, size: 16)),
                            Text(kategori, style: TextStyle(color: selected ? Colors.white : AppTheme.textPrimary, fontSize: 13)),
                          ])),
                        ),
                      ),
                    ));
                  }).toList()),
                  const SizedBox(height: 20),
                  _label('Harga Menu', required: true),
                  TextFormField(
                    controller: _harga,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: _inputDecoration('15.000', prefix: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Center(widthFactor: 1, child: Text('Rp', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 16))))),
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      if (n == null || n <= 0) return 'Masukkan harga lebih dari Rp0';
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text('Tentukan harga jual yang ramah mahasiswa', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                ])),
                const SizedBox(height: 18),
                _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Expanded(child: Text('Deskripsi Singkat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
                    _chip('Opsional', const Color(0xFFF7EBEB), AppTheme.textSecondary),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _deskripsi,
                      builder: (_, value, __) => Text('${value.text.length}/200', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _deskripsi,
                    maxLines: 4,
                    maxLength: 200,
                    decoration: _inputDecoration('Ceritakan rasa, bahan, porsi, atau keunikan menu ini...').copyWith(counterText: ''),
                  ),
                ])),
                const SizedBox(height: 18),
                _panel(Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      const Flexible(child: Text('Status Ketersediaan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      const SizedBox(width: 8),
                      _chip(_tersedia ? 'Tersedia' : 'Habis', _tersedia ? const Color(0xFFE4F5EA) : const Color(0xFFFBE5E5), _tersedia ? const Color(0xFF138344) : AppTheme.accent),
                    ]),
                    const SizedBox(height: 6),
                    const Text('Menu langsung dapat dipesan mahasiswa', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                  ])),
                  Switch(
                    value: _tersedia,
                    onChanged: (v) => setState(() => _tersedia = v),
                    activeTrackColor: const Color(0xFF138344),
                    inactiveTrackColor: const Color(0xFFE9DADA),
                    thumbColor: WidgetStateProperty.all(Colors.white),
                    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                ])),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFF9E9EB), borderRadius: BorderRadius.circular(16)),
                  child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.lightbulb_outline, color: AppTheme.primary),
                    SizedBox(width: 10),
                    Expanded(child: Text('Tips Pojok Kantin: Foto menarik dan deskripsi yang jelas dapat membantu mahasiswa memilih menu.', style: TextStyle(color: AppTheme.textPrimary, height: 1.5, fontSize: 12))),
                  ]),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _simpan,
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    icon: const Icon(Icons.check),
                    label: const Text('Simpan Menu', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal', style: TextStyle(color: AppTheme.textSecondary))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, Color bg, Color fg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Text(label, style: TextStyle(fontSize: 11, color: fg)),
      );
}
