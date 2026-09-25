import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final name = TextEditingController(text: 'Hendrawan Pradipta, S.E., M.M.');
  final email = TextEditingController(text: 'hendrawan@equityworld-futures.com');
  final phone = TextEditingController(text: '+62 812-0000-0000');
  final wpb = TextEditingController(text: 'WPB-BAPPEBTI-88294');
  final unit = TextEditingController(text: 'Surabaya - Trilium Office Lt. 2');

  @override
  void dispose() {
    name.dispose(); email.dispose(); phone.dispose(); wpb.dispose(); unit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil & Pengaturan', style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, '/notifications'), icon: const Icon(Icons.notifications_none_rounded)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _profileHero(),
          const SizedBox(height: 14),
          _tabs(),
          const SizedBox(height: 14),
          _section('Data Legalitas & Kontak', Icons.assignment_ind_rounded, [
            _field('Nama Lengkap (Sesuai KTP / SK BAPPEBTI)', name, Icons.person_outline),
            _field('Email Perusahaan Terverifikasi', email, Icons.mail_outline, suffix: 'Terverifikasi'),
            _field('Nomor Telepon / WhatsApp Operasional', phone, Icons.call_outlined),
            _field('Nomor Registrasi / Izin WPB BAPPEBTI', wpb, Icons.verified_user_outlined, suffix: 'Resmi Terdaftar'),
            _field('Unit Kantor & Afiliasi', unit, Icons.domain_outlined),
            Row(children: [
              Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Reset'))),
              const SizedBox(width: 10),
              Expanded(child: FilledButton.icon(onPressed: () => _saved(context), icon: const Icon(Icons.save_outlined, size: 18), label: const Text('Simpan Perubahan'))),
            ]),
          ]),
          const SizedBox(height: 14),
          _section('Kredensial & Otentikasi', Icons.security_rounded, [
            _InfoTile(icon: Icons.phonelink_lock_rounded, title: 'Two-Factor Authentication', value: 'Google Authenticator (Aktif)', action: 'Kelola'),
            _InfoTile(icon: Icons.password_rounded, title: 'Kata Sandi Terminal', value: 'Terakhir diubah 45 hari yang lalu', action: 'Perbarui Password'),
            _InfoTile(icon: Icons.smartphone_rounded, title: 'Sesi Login Aktif', value: 'Mobile Device • Internal Pulse App', action: 'Online'),
          ]),
          const SizedBox(height: 14),
          _section('Preferensi Tampilan Terminal', Icons.display_settings_rounded, [
            _ToggleRow(title: 'Streaming Live Ticker Emas (XAU/USD)', subtitle: 'Pembaruan data harga dan spread secara real-time'),
            _ToggleRow(title: 'Alert Penembusan Pivot & Resistance', subtitle: 'Kirim peringatan instan saat harga menyentuh R1/R2/S1/S2'),
            const ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.stacked_line_chart_rounded), title: Text('Satuan Dasar Lot Margin', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), subtitle: Text('1.00 Lot (100 oz)')),
          ]),
          const SizedBox(height: 14),
          _activity(),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Keluar dari Akun (Logout)'),
            style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFFDC2626)),
          ),
          const SizedBox(height: 16),
          const Center(child: Text('PT EQUITYWORLD FUTURES • Versi Terminal Portal v4.2.1', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)))),
        ],
      ),
    );
  }

  Widget _profileHero() => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(14)),
    child: Row(children: [
      const CircleAvatar(radius: 34, backgroundColor: Color(0xFFE5EEFF), child: Icon(Icons.person, size: 38, color: Color(0xFF0F172A))),
      const SizedBox(width: 14),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('AKUN ANALIS TERVERIFIKASI', style: TextStyle(fontSize: 9, color: Color(0xFFD4AF37), fontWeight: FontWeight.w800, letterSpacing: 1)),
        SizedBox(height: 6),
        Text('Hendrawan Pradipta, S.E., M.M.', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        SizedBox(height: 3),
        Text('Senior Commodity & Bullion Analyst', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 11)),
        SizedBox(height: 2),
        Text('EWF-ID-88294 • Divisi Riset & Analisis Komoditas', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10)),
      ])),
    ]),
  );

  Widget _tabs() => Row(children: [
    Expanded(child: FilledButton(onPressed: () {}, child: const Text('Data Pribadi'))),
    const SizedBox(width: 8),
    Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Keamanan'))),
    const SizedBox(width: 8),
    Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Preferensi'))),
  ]);

  Widget _section(String title, IconData icon, List<Widget> children) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Icon(icon, size: 19, color: const Color(0xFFB8860B)), const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))]),
      const SizedBox(height: 14),
      ...children.map((e) => Padding(padding: const EdgeInsets.only(bottom: 12), child: e)),
    ]),
  );

  Widget _field(String label, TextEditingController c, IconData icon, {String? suffix}) => TextField(
    controller: c,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 19),
      suffixText: suffix,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
    ),
    style: const TextStyle(fontSize: 13),
  );

  Widget _activity() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFFFFFBF0), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFF5E8C7))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Aktivitas & Integritas Analis', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      const Text('Q3 2024', style: TextStyle(fontSize: 11, color: Color(0xFF8C6D1F), fontWeight: FontWeight.w700)),
      const SizedBox(height: 14),
      Row(children: const [
        Expanded(child: _Stat(value: '142', label: 'Analisis Emas')),
        Expanded(child: _Stat(value: '94.2%', label: 'Akurasi Pivot')),
        Expanded(child: _Stat(value: '100%', label: 'Kepatuhan')),
      ]),
    ]),
  );

  void _saved(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Data berhasil diperbarui dan disinkronkan ke server internal.')),
  );
}

class _InfoTile extends StatelessWidget {
  final IconData icon; final String title, value, action;
  const _InfoTile({required this.icon, required this.title, required this.value, required this.action});
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(9)), child: Icon(icon, size: 19)),
    title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    subtitle: Text(value, style: const TextStyle(fontSize: 11)),
    trailing: Text(action, style: const TextStyle(fontSize: 10, color: Color(0xFFB8860B), fontWeight: FontWeight.w800)),
  );
}

class _ToggleRow extends StatelessWidget {
  final String title, subtitle;
  const _ToggleRow({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => SwitchListTile(
    contentPadding: EdgeInsets.zero,
    value: true,
    onChanged: (_) {},
    title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    subtitle: Text(subtitle, style: const TextStyle(fontSize: 10.5)),
  );
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Color(0xFF8C6D1F))),
    const SizedBox(height: 3),
    Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
  ]);
}
